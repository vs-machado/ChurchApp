import 'dart:io';

import 'package:church_app/core/auth/domain/auth_service.dart';
import 'package:church_app/core/auth/presentation/viewmodels/register/register_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RegisterViewModel extends StateNotifier<RegisterState> {
  final AuthService _authService;

  RegisterViewModel({required AuthService authService})
    : _authService = authService,
      super(const RegisterInitial());

  void signUp(String email, String password, String confirmPassword) async {
    state = const RegisterLoading();

    if (password != confirmPassword) {
      state = const RegisterError(
        "As senhas inseridas não são iguais. Tente novamente.",
      );
      return;
    }

    try {
      await _authService.signUpWithEmailPassword(email, password);
      state = const RegisterSuccess();
    } on SocketException catch (_) {
      state = const RegisterError("Erro: sem conexão com a internet.");
    } on AuthException catch (e) {
      state = RegisterError(
        "Falha no cadastro. Tente novamente mais tarde.",
      ); //
    } catch (e) {
      state = const RegisterError(
        "Algo deu errado. Tente novamente mais tarde.",
      );
    }
  }
}
