import 'package:church_app/core/domain/util/error.dart';
import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';

enum AuthError implements Error {
  invalidEmail,
  passwordsAreNotTheSame,
  passwordRequiresLettersAndNumbers,
  registerFailed,
  loginFailed,
  incorrectPassword,
  emailAlreadyInUse,
  emptyPassword,
  emptyName,
}

extension ErrorMessage on AuthError {
  String toErrorString(BuildContext context) {
    return switch (this) {
      AuthError.invalidEmail => S.of(context).insertAValidEmail,
      AuthError.passwordsAreNotTheSame => S.of(context).passwordsAreNotTheSame,
      AuthError.passwordRequiresLettersAndNumbers =>
        S.of(context).passwordRequiresLettersAndNumbers,
      AuthError.registerFailed => S.of(context).registerFailed,
      AuthError.loginFailed => S.of(context).somethingWentWrong,
      AuthError.incorrectPassword => S.of(context).incorrectPassword,
      AuthError.emailAlreadyInUse => S.of(context).emailAlreadyInUse,
      AuthError.emptyPassword => S.of(context).thePasswordFieldCantBeEmpty,
      AuthError.emptyName => S.of(context).nameFieldCantBeEmpty,
    };
  }
}
