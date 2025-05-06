import 'dart:io';

import 'package:church_app/core/auth/domain/auth_service.dart';
import 'package:church_app/core/auth/presentation/viewmodels/google_sign_in/google_sign_in_viewmodel.dart';
import 'package:church_app/core/auth/presentation/viewmodels/register/register_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:church_app/core/auth/util/auth_error.dart';
import 'package:church_app/core/domain/util/network_error.dart';

/// Realiza o cadastramento do usuário com email e senha.
///
/// Atualmente utiliza o sistema de cadastramento com email e senha do Supabase.
/// Para cadastro com Google Auth, ver [GoogleSignInViewModel].
class RegisterViewModel extends StateNotifier<RegisterState> {
  final AuthService<AuthResponse> _authService;

  RegisterViewModel({required AuthService<AuthResponse> authService})
    : _authService = authService,
      super(const RegisterInitial());

  /// Realiza o cadastramento do usuário ou exibe mensagem de erro.
  void signUp(
    String email,
    String password,
    String confirmPassword,
    String fullName,
  ) async {
    state = const RegisterLoading();

    if (password != confirmPassword) {
      state = RegisterError(AuthError.passwordsAreNotTheSame);
      return;
    }

    try {
      await _authService.signUpWithEmailPassword(email.toLowerCase(), password);

      // Atualiza o nome do usuário na tabela users
      await _authService.updateUserProfile(data: {'name': fullName});

      state = const RegisterSuccess();
    } on SocketException catch (_) {
      state = RegisterError(NetworkError.noInternetConnection);
    } on AuthRetryableFetchException catch (_) {
      state = RegisterError(NetworkError.requestTimeout);
    } on AuthException catch (e) {
      if (e.message.toLowerCase().contains('user already registered') ||
          e.message.toLowerCase().contains('email address already exists')) {
        state = RegisterError(AuthError.emailAlreadyInUse);
      } else if (e.statusCode == '500') {
        state = RegisterError(NetworkError.serverError);
      } else if (e.statusCode == '429') {
        state = RegisterError(NetworkError.tooManyRequests);
      } else {
        state = RegisterError(AuthError.registerFailed);
      }
    } catch (e) {
      state = RegisterError(NetworkError.unknown);
    }
  }
}
