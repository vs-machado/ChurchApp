/// Recebe os dados do usuário autenticado.
class UserDto {
  /// Identificador único do usuário.
  final String id;

  /// Nome do usuário.
  final String name;

  /// Função do usuário.
  ///
  /// Exemplo: user, admin, creator.
  final String role;

  /// URL do avatar do usuário (opcional).
  final String? avatarUrl;

  UserDto({
    required this.id,
    required this.name,
    required this.role,
    this.avatarUrl,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) {
    return UserDto(
      id: json['id'],
      name: json['name'],
      role: json['role'],
      avatarUrl: json['avatar_url'],
    );
  }
}
