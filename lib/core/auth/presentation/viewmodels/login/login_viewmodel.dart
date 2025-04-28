import 'package:church_app/core/auth/domain/auth_service.dart';
import 'package:church_app/core/auth/presentation/viewmodels/login/login_state.dart';
import 'package:church_app/core/auth/util/auth_error.dart';
import 'package:riverpod/riverpod.dart';
import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../domain/util/network_error.dart';

class LoginViewModel extends StateNotifier<LoginState> {
  final AuthService _authService;

  LoginViewModel({required AuthService authService})
    : _authService = authService,
      super(LoginInitial());

  void login(String email, String password) async {
    state = LoginLoading();

    try {
      await _authService.signInWithEmailPassword(email, password);
      state = LoginSuccess();
    } on SocketException catch (_) {
      state = LoginError(NetworkError.noInternetConnection);
    } on AuthRetryableFetchException catch (_) {
      state = LoginError(NetworkError.requestTimeout);
    } on AuthException catch (e) {
      if (e.statusCode == '500') {
        state = LoginError(NetworkError.serverError);
      }
      if (e.statusCode == '429') {
        state = LoginError(NetworkError.tooManyRequests);
      } else if (e.message.toLowerCase().contains(
            'invalid login credentials',
          ) ||
          e.message.toLowerCase().contains('incorrect password')) {
        state = LoginError(AuthError.incorrectPassword);
      } else {
        state = LoginError(AuthError.loginFailed);
      }
    } catch (e) {
      state = LoginError(NetworkError.unknown);
    }
  }
}
