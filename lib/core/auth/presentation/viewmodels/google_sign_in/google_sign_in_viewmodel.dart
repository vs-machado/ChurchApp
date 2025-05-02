import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../domain/util/network_error.dart';
import '../../../domain/auth_service.dart';
import 'google_sign_in_state.dart';

class GoogleSignInViewModel extends StateNotifier<GoogleSignInState> {
  final AuthService _authService;

  GoogleSignInViewModel({required AuthService authService})
    : _authService = authService,
      super(const SignInInitial());

  void signInWithGoogle() async {
    state = const SignInLoading();

    try {
      await _authService.signInWithGoogle();
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
