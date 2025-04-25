class RegisterState {
  final bool isLoading;
  final bool isSuccess;
  final bool isError;
  final String? errorMessage;

  RegisterState({
    this.isLoading = false, 
    this.isSuccess = false,
    this.isError = false,
    this.errorMessage
  });

  RegisterState copyWith({
    bool? isLoading,
    bool? isSuccess,
    bool? isError,
    String? errorMessage,
  }) {
    return RegisterState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isError: isError ?? this.isError,
      errorMessage: errorMessage ?? this.errorMessage
    );
  }
}