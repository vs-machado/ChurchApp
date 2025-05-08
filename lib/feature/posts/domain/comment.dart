import 'package:uuid/uuid.dart';

/// Representa um comentário na camada domain
class Comment {
  /// Identificador único do comentário.
  final int id;

  /// Identificador único da postagem que o comentário pertence.
  final int postId;

  /// Identificador único do usuário que fez o comentário.
  final Uuid userId;

  /// Conteúdo do comentário.
  final String text;

  /// URL da imagem anexada ao comentário.
  final String? imageUrl;

  /// URL do vídeo anexado ao comentário.
  final String? videoUrl;

  /// Data e hora em que o comentário foi criado.
  final DateTime createdAt;

  /// Data e hora em que o comentário foi editado pela última vez.
  final DateTime? editedAt;

  Comment({
    required this.id,
    required this.postId,
    required this.userId,
    required this.text,
    this.imageUrl,
    this.videoUrl,
    required this.createdAt,
    this.editedAt,
  });
}
