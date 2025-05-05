// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name =
        (locale.countryCode?.isEmpty ?? false)
            ? locale.languageCode
            : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Home page`
  String get homePage {
    return Intl.message('Home page', name: 'homePage', desc: '', args: []);
  }

  /// `Welcome!`
  String get welcome {
    return Intl.message('Welcome!', name: 'welcome', desc: '', args: []);
  }

  /// `Posts loaded.`
  String get postsLoaded {
    return Intl.message(
      'Posts loaded.',
      name: 'postsLoaded',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred. Try again.`
  String get anErrorOccurred {
    return Intl.message(
      'An error occurred. Try again.',
      name: 'anErrorOccurred',
      desc: '',
      args: [],
    );
  }

  /// `Registration`
  String get registration {
    return Intl.message(
      'Registration',
      name: 'registration',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message('Email', name: 'email', desc: '', args: []);
  }

  /// `Password`
  String get password {
    return Intl.message('Password', name: 'password', desc: '', args: []);
  }

  /// `Confirm password`
  String get confirmPassword {
    return Intl.message(
      'Confirm password',
      name: 'confirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get register {
    return Intl.message('Register', name: 'register', desc: '', args: []);
  }

  /// `Enter a valid email.`
  String get insertAValidEmail {
    return Intl.message(
      'Enter a valid email.',
      name: 'insertAValidEmail',
      desc: '',
      args: [],
    );
  }

  /// `Password must have at least 8 characters and contain letters and numbers.`
  String get passwordRequiresLettersAndNumbers {
    return Intl.message(
      'Password must have at least 8 characters and contain letters and numbers.',
      name: 'passwordRequiresLettersAndNumbers',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message('Login', name: 'login', desc: '', args: []);
  }

  /// `Don't have an account? Register`
  String get doesnHaveAnAccountRegister {
    return Intl.message(
      'Don\'t have an account? Register',
      name: 'doesnHaveAnAccountRegister',
      desc: '',
      args: [],
    );
  }

  /// `No internet connection. Please check your network and try again.`
  String get noInternetConnection {
    return Intl.message(
      'No internet connection. Please check your network and try again.',
      name: 'noInternetConnection',
      desc: '',
      args: [],
    );
  }

  /// `The request timed out. Please try again.`
  String get requestTimeout {
    return Intl.message(
      'The request timed out. Please try again.',
      name: 'requestTimeout',
      desc: '',
      args: [],
    );
  }

  /// `Too many requests. Please wait a moment and try again.`
  String get tooManyRequests {
    return Intl.message(
      'Too many requests. Please wait a moment and try again.',
      name: 'tooManyRequests',
      desc: '',
      args: [],
    );
  }

  /// `Registration failed. Please try again.`
  String get registerFailed {
    return Intl.message(
      'Registration failed. Please try again.',
      name: 'registerFailed',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong. Please try again.`
  String get somethingWentWrong {
    return Intl.message(
      'Something went wrong. Please try again.',
      name: 'somethingWentWrong',
      desc: '',
      args: [],
    );
  }

  /// `A server error occurred. Please try again later.`
  String get serverError {
    return Intl.message(
      'A server error occurred. Please try again later.',
      name: 'serverError',
      desc: '',
      args: [],
    );
  }

  /// `Passwords do not match. Please try again.`
  String get passwordsAreNotTheSame {
    return Intl.message(
      'Passwords do not match. Please try again.',
      name: 'passwordsAreNotTheSame',
      desc: '',
      args: [],
    );
  }

  /// `Incorrect email or password. Please check your credentials and try again.`
  String get incorrectPassword {
    return Intl.message(
      'Incorrect email or password. Please check your credentials and try again.',
      name: 'incorrectPassword',
      desc: '',
      args: [],
    );
  }

  /// `Error: This email has already been registered.`
  String get emailAlreadyInUse {
    return Intl.message(
      'Error: This email has already been registered.',
      name: 'emailAlreadyInUse',
      desc: '',
      args: [],
    );
  }

  /// `Welcome to Reino Church!`
  String get welcomeTo {
    return Intl.message(
      'Welcome to Reino Church!',
      name: 'welcomeTo',
      desc: '',
      args: [],
    );
  }

  /// `Sign in with Google account`
  String get signInGoogleAccount {
    return Intl.message(
      'Sign in with Google account',
      name: 'signInGoogleAccount',
      desc: '',
      args: [],
    );
  }

  /// `Register with email and password`
  String get registerEmailPassword {
    return Intl.message(
      'Register with email and password',
      name: 'registerEmailPassword',
      desc: '',
      args: [],
    );
  }

  /// `Enter`
  String get enter {
    return Intl.message('Enter', name: 'enter', desc: '', args: []);
  }

  /// `Create your account`
  String get createYourAccount {
    return Intl.message(
      'Create your account',
      name: 'createYourAccount',
      desc: '',
      args: [],
    );
  }

  /// `or`
  String get or {
    return Intl.message('or', name: 'or', desc: '', args: []);
  }

  /// `Already have an account?`
  String get haveAnAccount {
    return Intl.message(
      'Already have an account?',
      name: 'haveAnAccount',
      desc: '',
      args: [],
    );
  }

  /// `The password field cannot be empty`
  String get thePasswordFieldCantBeEmpty {
    return Intl.message(
      'The password field cannot be empty',
      name: 'thePasswordFieldCantBeEmpty',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'pt'),
      Locale.fromSubtags(languageCode: 'pt', countryCode: 'BR'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
