import 'package:church_app/core/domain/util/error.dart';

sealed class RegisterState {
  const RegisterState();
}

class RegisterInitial extends RegisterState {
  const RegisterInitial();
}

class RegisterLoading extends RegisterState {
  const RegisterLoading();
}

class RegisterSuccess extends RegisterState {
  const RegisterSuccess();
}

class RegisterError extends RegisterState {
  final Error error;
  
  const RegisterError(this.error);
}