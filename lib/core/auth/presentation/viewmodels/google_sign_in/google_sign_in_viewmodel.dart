import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../domain/util/network_error.dart';
import '../../../domain/auth_service.dart';
import 'google_sign_in_state.dart';

/// Realiza o sign in com Google Auth. Pode ser utilizado para cadastro e login.
class GoogleSignInViewModel extends StateNotifier<GoogleSignInState> {
  final AuthService<AuthResponse> _authService;

  GoogleSignInViewModel({required AuthService<AuthResponse> authService})
    : _authService = authService,
      super(const SignInInitial());

  /// Realiza o cadastro ou login do usuário, a depender se é o primeiro acesso ou não.
  void signInWithGoogle() async {
    state = const SignInLoading();

    try {
      await _authService.signInWithGoogle();

      final userMetadata = _authService.getCurrentUserMetadata();
      if (userMetadata != null) {
        final name = userMetadata['name'] as String?;

        if (name != null) {
          // Atualiza a tabela users com o nome da tabela auth
          await _authService.updateUserProfile(data: {'name': name});
        }
      }

      state = const SignInSuccess();
    } on SocketException catch (_) {
      state = const SignInError(NetworkError.noInternetConnection);
    } on AuthRetryableFetchException catch (_) {
      state = const SignInError(NetworkError.requestTimeout);
    } on AuthException catch (e) {
      if (e.statusCode == '500') {
        state = const SignInError(NetworkError.serverError);
      } else if (e.statusCode == '429') {
        state = const SignInError(NetworkError.tooManyRequests);
      } else {
        state = const SignInError(NetworkError.unknown);
      }
    } catch (e) {
      state = const SignInError(NetworkError.unknown);
    }
  }
}
