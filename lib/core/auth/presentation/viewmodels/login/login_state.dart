import 'package:church_app/core/domain/util/error.dart';

// Gerenciador de estado do login
sealed class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginError extends LoginState {
  final Error error;

  LoginError(this.error);
}

class LoginSuccess extends LoginState {}
