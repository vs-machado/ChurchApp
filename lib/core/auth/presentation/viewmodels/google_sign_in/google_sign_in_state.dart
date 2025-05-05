import 'package:church_app/core/domain/util/error.dart';

sealed class GoogleSignInState {
  const GoogleSignInState();
}

class SignInInitial extends GoogleSignInState {
  const SignInInitial();
}

class SignInLoading extends GoogleSignInState {
  const SignInLoading();
}

class SignInSuccess extends GoogleSignInState {
  const SignInSuccess();
}

class SignInError extends GoogleSignInState {
  final Error error;

  const SignInError(this.error);
}
