import 'package:uuid/uuid_value.dart';

/// Representa os dados de um usuário no sistema.
///
/// Contém as informações básicas para identificação e exibição de um usuário.
class User {
  /// Identificador único do usuário
  final UuidValue id;

  /// Nome de exibição do usuário
  final String name;

  /// URL da imagem de avatar do usuário
  /// Pode ser null quando o usuário não possui avatar configurado
  final String? avatarUrl;

  const User._({required this.id, required this.name, this.avatarUrl});

  factory User({
    required UuidValue id,
    required String name,
    String? avatarUrl,
  }) {
    if (name.isEmpty) {
      throw ArgumentError('Username cannot be empty');
    }

    if (name.length > 40) {
      throw ArgumentError('Username cannot be longer than 40 characters');
    }

    if (avatarUrl != null && !avatarUrl.startsWith('http')) {
      throw ArgumentError('Invalid avatar URL.');
    }

    return User._(id: id, name: name, avatarUrl: avatarUrl);
  }
}
