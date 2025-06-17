import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_pt.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('pt'),
    Locale('pt', 'BR'),
  ];

  /// No description provided for @homePage.
  ///
  /// In pt_BR, this message translates to:
  /// **'Página inicial'**
  String get homePage;

  /// No description provided for @welcome.
  ///
  /// In pt_BR, this message translates to:
  /// **'Bem-vindo!'**
  String get welcome;

  /// No description provided for @postsLoaded.
  ///
  /// In pt_BR, this message translates to:
  /// **'Posts carregados.'**
  String get postsLoaded;

  /// No description provided for @anErrorOccurred.
  ///
  /// In pt_BR, this message translates to:
  /// **'Ocorreu um erro. Tente novamente.'**
  String get anErrorOccurred;

  /// No description provided for @registration.
  ///
  /// In pt_BR, this message translates to:
  /// **'Cadastro'**
  String get registration;

  /// No description provided for @email.
  ///
  /// In pt_BR, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In pt_BR, this message translates to:
  /// **'Senha'**
  String get password;

  /// No description provided for @confirmPassword.
  ///
  /// In pt_BR, this message translates to:
  /// **'Confirmar senha'**
  String get confirmPassword;

  /// No description provided for @insertAValidEmail.
  ///
  /// In pt_BR, this message translates to:
  /// **'Insira um email válido.'**
  String get insertAValidEmail;

  /// No description provided for @passwordRequiresLettersAndNumbers.
  ///
  /// In pt_BR, this message translates to:
  /// **'A senha deve possuir no mínimo 8 caracteres e conter letras e números.'**
  String get passwordRequiresLettersAndNumbers;

  /// No description provided for @register.
  ///
  /// In pt_BR, this message translates to:
  /// **'Cadastrar'**
  String get register;

  /// No description provided for @login.
  ///
  /// In pt_BR, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @doesnHaveAnAccountRegister.
  ///
  /// In pt_BR, this message translates to:
  /// **'Não possui uma conta? Cadastre-se'**
  String get doesnHaveAnAccountRegister;

  /// No description provided for @noInternetConnection.
  ///
  /// In pt_BR, this message translates to:
  /// **'Erro: sem conexão com a internet.'**
  String get noInternetConnection;

  /// No description provided for @somethingWentWrong.
  ///
  /// In pt_BR, this message translates to:
  /// **'Algo deu errado. Tente novamente mais tarde.'**
  String get somethingWentWrong;

  /// No description provided for @passwordsAreNotTheSame.
  ///
  /// In pt_BR, this message translates to:
  /// **'As senhas inseridas não são iguais. Tente novamente.'**
  String get passwordsAreNotTheSame;

  /// No description provided for @registerFailed.
  ///
  /// In pt_BR, this message translates to:
  /// **'Falha no cadastro. Tente novamente mais tarde.'**
  String get registerFailed;

  /// No description provided for @requestTimeout.
  ///
  /// In pt_BR, this message translates to:
  /// **'A conexão expirou. Por favor, tente novamente.'**
  String get requestTimeout;

  /// No description provided for @tooManyRequests.
  ///
  /// In pt_BR, this message translates to:
  /// **'Muitas requisições. Por favor, aguarde um momento e tente novamente.'**
  String get tooManyRequests;

  /// No description provided for @serverError.
  ///
  /// In pt_BR, this message translates to:
  /// **'Ocorreu um erro no servidor. Por favor, tente novamente mais tarde.'**
  String get serverError;

  /// No description provided for @incorrectPassword.
  ///
  /// In pt_BR, this message translates to:
  /// **'Email ou senha incorretos. Corrija e tente novamente.'**
  String get incorrectPassword;

  /// No description provided for @emailAlreadyInUse.
  ///
  /// In pt_BR, this message translates to:
  /// **'Erro: Este email já foi cadastrado anteriormente.'**
  String get emailAlreadyInUse;

  /// No description provided for @welcomeTo.
  ///
  /// In pt_BR, this message translates to:
  /// **'Bem vindo ao Reino Church!'**
  String get welcomeTo;

  /// No description provided for @signInGoogleAccount.
  ///
  /// In pt_BR, this message translates to:
  /// **'Entrar com conta Google'**
  String get signInGoogleAccount;

  /// No description provided for @registerEmailPassword.
  ///
  /// In pt_BR, this message translates to:
  /// **'Registrar com email e senha'**
  String get registerEmailPassword;

  /// No description provided for @enter.
  ///
  /// In pt_BR, this message translates to:
  /// **'Entrar'**
  String get enter;

  /// No description provided for @createYourAccount.
  ///
  /// In pt_BR, this message translates to:
  /// **'Crie sua conta'**
  String get createYourAccount;

  /// No description provided for @or.
  ///
  /// In pt_BR, this message translates to:
  /// **'ou'**
  String get or;

  /// No description provided for @haveAnAccount.
  ///
  /// In pt_BR, this message translates to:
  /// **'Possui uma conta? '**
  String get haveAnAccount;

  /// No description provided for @thePasswordFieldCantBeEmpty.
  ///
  /// In pt_BR, this message translates to:
  /// **'O campo senha não pode estar vazio'**
  String get thePasswordFieldCantBeEmpty;

  /// No description provided for @nameFieldCantBeEmpty.
  ///
  /// In pt_BR, this message translates to:
  /// **'O campo nome não pode estar vazio.'**
  String get nameFieldCantBeEmpty;

  /// No description provided for @fullName.
  ///
  /// In pt_BR, this message translates to:
  /// **'Nome completo'**
  String get fullName;

  /// No description provided for @likesCount.
  ///
  /// In pt_BR, this message translates to:
  /// **'{count, plural, =0{} =1{count} other{{count}}}'**
  String likesCount(int count);

  /// No description provided for @leaveAComment.
  ///
  /// In pt_BR, this message translates to:
  /// **'Deixe um comentário'**
  String get leaveAComment;

  /// No description provided for @postDetails.
  ///
  /// In pt_BR, this message translates to:
  /// **'Detalhes da postagem'**
  String get postDetails;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'pt'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when language+country codes are specified.
  switch (locale.languageCode) {
    case 'pt':
      {
        switch (locale.countryCode) {
          case 'BR':
            return AppLocalizationsPtBr();
        }
        break;
      }
  }

  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'pt':
      return AppLocalizationsPt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
