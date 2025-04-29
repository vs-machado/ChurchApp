// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a pt_BR locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'pt_BR';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "anErrorOccurred": MessageLookupByLibrary.simpleMessage(
      "Ocorreu um erro. Tente novamente.",
    ),
    "confirmPassword": MessageLookupByLibrary.simpleMessage("Confirmar senha"),
    "doesnHaveAnAccountRegister": MessageLookupByLibrary.simpleMessage(
      "Não possui uma conta? Cadastre-se",
    ),
    "email": MessageLookupByLibrary.simpleMessage("Email"),
    "emailAlreadyInUse": MessageLookupByLibrary.simpleMessage(
      "Erro: Este email já foi cadastrado anteriormente.",
    ),
    "homePage": MessageLookupByLibrary.simpleMessage("Página inicial"),
    "incorrectPassword": MessageLookupByLibrary.simpleMessage(
      "Email ou senha incorretos. Corrija e tente novamente.",
    ),
    "insertAValidEmail": MessageLookupByLibrary.simpleMessage(
      "Insira um email válido.",
    ),
    "login": MessageLookupByLibrary.simpleMessage("Login"),
    "noInternetConnection": MessageLookupByLibrary.simpleMessage(
      "Erro: sem conexão com a internet.",
    ),
    "password": MessageLookupByLibrary.simpleMessage("Senha"),
    "passwordRequiresLettersAndNumbers": MessageLookupByLibrary.simpleMessage(
      "A senha deve possuir no mínimo 8 caracteres e conter letras e números.",
    ),
    "passwordsAreNotTheSame": MessageLookupByLibrary.simpleMessage(
      "As senhas inseridas não são iguais. Tente novamente.",
    ),
    "postsLoaded": MessageLookupByLibrary.simpleMessage("Posts carregados."),
    "register": MessageLookupByLibrary.simpleMessage("Cadastrar"),
    "registerFailed": MessageLookupByLibrary.simpleMessage(
      "Falha no cadastro. Tente novamente mais tarde.",
    ),
    "registration": MessageLookupByLibrary.simpleMessage("Cadastro"),
    "requestTimeout": MessageLookupByLibrary.simpleMessage(
      "A conexão expirou. Por favor, tente novamente.",
    ),
    "serverError": MessageLookupByLibrary.simpleMessage(
      "Ocorreu um erro no servidor. Por favor, tente novamente mais tarde.",
    ),
    "somethingWentWrong": MessageLookupByLibrary.simpleMessage(
      "Algo deu errado. Tente novamente mais tarde.",
    ),
    "tooManyRequests": MessageLookupByLibrary.simpleMessage(
      "Muitas requisições. Por favor, aguarde um momento e tente novamente.",
    ),
    "welcome": MessageLookupByLibrary.simpleMessage("Bem-vindo!"),
  };
}
