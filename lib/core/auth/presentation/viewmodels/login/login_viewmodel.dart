import 'package:church_app/core/auth/domain/auth_service.dart';
import 'package:church_app/core/auth/presentation/viewmodels/login/login_state.dart';
import 'package:riverpod/riverpod.dart';
import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';

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
      state = LoginError("Erro: sem conexão com a internet.");
    } on AuthException catch (e) {
      state = LoginError(e.message);
    } catch (e) {
      state = LoginError("Algo deu errado. Tente novamente mais tarde.");
    }
  }
}