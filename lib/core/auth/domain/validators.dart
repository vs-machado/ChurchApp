/// Valida emails e senhas
///
/// As senhas devem conter no mínimo 8 caracteres e pelo menos
/// uma letra e um número.
extension EmailValidator on String {
  bool isValidEmail() {
    final emailRegex = RegExp(r"^[\w\-\.]+@([\w\-]+\.)+[\w\-]{2,4}$");
    return emailRegex.hasMatch(this);
  }

  bool isValidPassword() {
    return length >= 8 &&
        contains(RegExp(r'[a-zA-Z]')) &&
        contains(RegExp(r'[0-9]'));
  }
}
