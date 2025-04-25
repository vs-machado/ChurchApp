import 'package:church_app/core/auth/domain/auth_service.dart';
import 'package:church_app/core/auth/presentation/viewmodels/login/login_state.dart';
import 'package:riverpod/riverpod.dart';
import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginViewModel extends StateNotifier<LoginState> {
  final AuthService _authService;

  LoginViewModel({required AuthService authService})
    : _authService = authService,
      super(LoginState());

  void login(String email, String password) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      await _authService.signInWithEmailPassword(email, password);
      state = state.copyWith(isLoading: false);
    } on SocketException catch (_) {
      state = state.copyWith(
        isLoading: false,
        isError: true,
        errorMessage: "Erro: sem conexão com a internet.",
      );
    } on AuthException catch (e) {
      state = state.copyWith(
        isLoading: false,
        isError: true,
        errorMessage: e.message //"Falha no login. Tente novamente mais tarde.",
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        isError: true,
        errorMessage: "Algo deu errado. Tente novamente mais tarde.",
      );
    }
  }
}
