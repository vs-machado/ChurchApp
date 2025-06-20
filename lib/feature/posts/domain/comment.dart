import '../../../core/domain/value_objects/user.dart';

/// Representa um comentário na camada domain
class Comment {
  /// Identificador único da postagem que o comentário pertence.
  final int postId;

  /// Identificador único do comentário.
  final int commentId;

  /// Usuário que enviou o comentário.
  final User user;

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
    required this.postId,
    required this.commentId,
    required this.user,
    required this.text,
    this.imageUrl,
    this.videoUrl,
    required this.createdAt,
    this.editedAt,
  });
}
