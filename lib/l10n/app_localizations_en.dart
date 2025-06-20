// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get homePage => 'Home page';

  @override
  String get welcome => 'Welcome!';

  @override
  String get postsLoaded => 'Posts loaded.';

  @override
  String get anErrorOccurred => 'An error occurred. Try again.';

  @override
  String get registration => 'Registration';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get confirmPassword => 'Confirm password';

  @override
  String get insertAValidEmail => 'Enter a valid email.';

  @override
  String get passwordRequiresLettersAndNumbers =>
      'Password must have at least 8 characters and contain letters and numbers.';

  @override
  String get register => 'Register';

  @override
  String get login => 'Login';

  @override
  String get doesnHaveAnAccountRegister => 'Don\'t have an account? Register';

  @override
  String get noInternetConnection =>
      'No internet connection. Please check your network and try again.';

  @override
  String get somethingWentWrong => 'Something went wrong. Please try again.';

  @override
  String get passwordsAreNotTheSame =>
      'Passwords do not match. Please try again.';

  @override
  String get registerFailed => 'Registration failed. Please try again.';

  @override
  String get requestTimeout => 'The request timed out. Please try again.';

  @override
  String get tooManyRequests =>
      'Too many requests. Please wait a moment and try again.';

  @override
  String get serverError => 'A server error occurred. Please try again later.';

  @override
  String get incorrectPassword =>
      'Incorrect email or password. Please check your credentials and try again.';

  @override
  String get emailAlreadyInUse =>
      'Error: This email has already been registered.';

  @override
  String get welcomeTo => 'Welcome to Reino Church!';

  @override
  String get signInGoogleAccount => 'Sign in with Google account';

  @override
  String get registerEmailPassword => 'Register with email and password';

  @override
  String get enter => 'Enter';

  @override
  String get createYourAccount => 'Create your account';

  @override
  String get or => 'or';

  @override
  String get haveAnAccount => 'Already have an account? ';

  @override
  String get thePasswordFieldCantBeEmpty =>
      'The password field cannot be empty';

  @override
  String get nameFieldCantBeEmpty => 'The name field can\'t be empty.';

  @override
  String get fullName => 'Full name';

  @override
  String likesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count',
      one: 'count',
      zero: '',
    );
    return '$_temp0';
  }

  @override
  String get leaveAComment => 'Leave a comment';

  @override
  String get postDetails => 'Post details';
}
