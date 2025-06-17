// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get homePage => 'Página inicial';

  @override
  String get welcome => 'Bem-vindo!';

  @override
  String get postsLoaded => 'Posts carregados.';

  @override
  String get anErrorOccurred => 'Ocorreu um erro. Tente novamente.';

  @override
  String get registration => 'Cadastro';

  @override
  String get email => 'Email';

  @override
  String get password => 'Senha';

  @override
  String get confirmPassword => 'Confirmar senha';

  @override
  String get insertAValidEmail => 'Insira um email válido.';

  @override
  String get passwordRequiresLettersAndNumbers =>
      'A senha deve possuir no mínimo 8 caracteres e conter letras e números.';

  @override
  String get register => 'Cadastrar';

  @override
  String get login => 'Login';

  @override
  String get doesnHaveAnAccountRegister => 'Não possui uma conta? Cadastre-se';

  @override
  String get noInternetConnection => 'Erro: sem conexão com a internet.';

  @override
  String get somethingWentWrong =>
      'Algo deu errado. Tente novamente mais tarde.';

  @override
  String get passwordsAreNotTheSame =>
      'As senhas inseridas não são iguais. Tente novamente.';

  @override
  String get registerFailed => 'Falha no cadastro. Tente novamente mais tarde.';

  @override
  String get requestTimeout => 'A conexão expirou. Por favor, tente novamente.';

  @override
  String get tooManyRequests =>
      'Demasiados pedidos. Por favor, aguarde um momento e tente novamente.';

  @override
  String get serverError =>
      'Ocorreu um erro no servidor. Por favor, tente novamente mais tarde.';

  @override
  String get incorrectPassword =>
      'Email ou senha incorretos. Corrija e tente novamente.';

  @override
  String get emailAlreadyInUse =>
      'Erro: Este email já foi cadastrado anteriormente.';

  @override
  String get welcomeTo => 'Bem vindo ao Reino Church!';

  @override
  String get signInGoogleAccount => 'Entrar com conta Google';

  @override
  String get registerEmailPassword => 'Registrar com email e senha';

  @override
  String get enter => 'Entrar';

  @override
  String get createYourAccount => 'Crie sua conta';

  @override
  String get or => 'ou';

  @override
  String get haveAnAccount => 'Possui uma conta? ';

  @override
  String get thePasswordFieldCantBeEmpty =>
      'O campo senha não pode estar vazio';

  @override
  String get nameFieldCantBeEmpty => 'O campo nome não pode estar vazio.';

  @override
  String get fullName => 'Nome completo';

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
  String get leaveAComment => 'Deixe um comentário';

  @override
  String get postDetails => 'Detalhes da postagem';
}

/// The translations for Portuguese, as used in Brazil (`pt_BR`).
class AppLocalizationsPtBr extends AppLocalizationsPt {
  AppLocalizationsPtBr() : super('pt_BR');

  @override
  String get homePage => 'Página inicial';

  @override
  String get welcome => 'Bem-vindo!';

  @override
  String get postsLoaded => 'Posts carregados.';

  @override
  String get anErrorOccurred => 'Ocorreu um erro. Tente novamente.';

  @override
  String get registration => 'Cadastro';

  @override
  String get email => 'Email';

  @override
  String get password => 'Senha';

  @override
  String get confirmPassword => 'Confirmar senha';

  @override
  String get insertAValidEmail => 'Insira um email válido.';

  @override
  String get passwordRequiresLettersAndNumbers =>
      'A senha deve possuir no mínimo 8 caracteres e conter letras e números.';

  @override
  String get register => 'Cadastrar';

  @override
  String get login => 'Login';

  @override
  String get doesnHaveAnAccountRegister => 'Não possui uma conta? Cadastre-se';

  @override
  String get noInternetConnection => 'Erro: sem conexão com a internet.';

  @override
  String get somethingWentWrong =>
      'Algo deu errado. Tente novamente mais tarde.';

  @override
  String get passwordsAreNotTheSame =>
      'As senhas inseridas não são iguais. Tente novamente.';

  @override
  String get registerFailed => 'Falha no cadastro. Tente novamente mais tarde.';

  @override
  String get requestTimeout => 'A conexão expirou. Por favor, tente novamente.';

  @override
  String get tooManyRequests =>
      'Muitas requisições. Por favor, aguarde um momento e tente novamente.';

  @override
  String get serverError =>
      'Ocorreu um erro no servidor. Por favor, tente novamente mais tarde.';

  @override
  String get incorrectPassword =>
      'Email ou senha incorretos. Corrija e tente novamente.';

  @override
  String get emailAlreadyInUse =>
      'Erro: Este email já foi cadastrado anteriormente.';

  @override
  String get welcomeTo => 'Bem vindo ao Reino Church!';

  @override
  String get signInGoogleAccount => 'Entrar com conta Google';

  @override
  String get registerEmailPassword => 'Registrar com email e senha';

  @override
  String get enter => 'Entrar';

  @override
  String get createYourAccount => 'Crie sua conta';

  @override
  String get or => 'ou';

  @override
  String get haveAnAccount => 'Possui uma conta? ';

  @override
  String get thePasswordFieldCantBeEmpty =>
      'O campo senha não pode estar vazio';

  @override
  String get nameFieldCantBeEmpty => 'O campo nome não pode estar vazio.';

  @override
  String get fullName => 'Nome completo';

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
  String get leaveAComment => 'Deixe um comentário';

  @override
  String get postDetails => 'Detalhes da postagem';
}
