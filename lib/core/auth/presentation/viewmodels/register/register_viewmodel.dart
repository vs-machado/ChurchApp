import 'dart:io';

import 'package:church_app/core/auth/domain/auth_service.dart';
import 'package:church_app/core/auth/presentation/viewmodels/register/register_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:church_app/core/auth/util/auth_error.dart';
import 'package:church_app/core/domain/util/network_error.dart';

class RegisterViewModel extends StateNotifier<RegisterState> {
  final AuthService _authService;

  RegisterViewModel({required AuthService authService})
    : _authService = authService,
      super(const RegisterInitial());

  void signUp(String email, String password, String confirmPassword) async {
    state = const RegisterLoading();

    if (password != confirmPassword) {
      state = RegisterError(AuthError.passwordsAreNotTheSame);
      return;
    }

    try {
      await _authService.signUpWithEmailPassword(email.toLowerCase(), password);
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
