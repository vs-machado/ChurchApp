// Gerenciador de estado do login
class LoginState {
  final bool isLoading;
  final bool isError;
  final String? errorMessage;

  LoginState({this.isLoading = false, this.isError = false, this.errorMessage});

  LoginState copyWith({bool? isLoading, bool? isError, String? errorMessage}) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
