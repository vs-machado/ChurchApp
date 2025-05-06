/// Interface para serviços de autenticação de usuários
abstract class AuthService<T> {
  /// Cadastro ou login com Google sign-in
  Future<void> signInWithGoogle();

  /// Login com email e senha
  Future<T> signInWithEmailPassword(String email, String password);

  /// Cadastro com email e senha
  Future<T> signUpWithEmailPassword(String email, String password);

  /// Logout do usuário
  Future<void> signOut();

  /// Retorna o email do usuário logado
  String? getCurrentUserEmail();

  /// Retorna o ID do usuário logado
  String? get userId;

  /// Atualiza os dados do perfil do usuário
  Future<void> updateUserProfile({required Map<String, dynamic> data});

  /// Retorna os metadados do usuário atual
  Map<String, dynamic>? getCurrentUserMetadata();
}
