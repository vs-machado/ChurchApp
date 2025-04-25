import 'dart:io';

import 'package:church_app/core/auth/domain/auth_service.dart';
import 'package:church_app/core/auth/presentation/viewmodels/register/register_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RegisterViewModel extends StateNotifier<RegisterState> {
  final AuthService _authService;

  RegisterViewModel({required AuthService authService})
    : _authService = authService,
      super(RegisterState());

  void signUp(String email, String password, String confirmPassword) async {
    state = RegisterState(isLoading: true);

    if (password != confirmPassword) {
      state = RegisterState(
        isLoading: false,
        isError: true,
        errorMessage: "As senhas inseridas não são iguais. Tente novamente.",
      );
      return;
    }

    try {
      await _authService.signUpWithEmailPassword(email, password);
      state = state.copyWith(isLoading: false, isSuccess: true);
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
        errorMessage: e.message //Falha no cadastro. Tente novamente mais tarde,
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
