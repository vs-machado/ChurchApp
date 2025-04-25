// Gerenciador de estado do login
sealed class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginError extends LoginState {
  final String message;

  LoginError(this.message);
}

class LoginSuccess extends LoginState {}