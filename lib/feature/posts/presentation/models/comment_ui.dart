import 'package:uuid/uuid_value.dart';

/// Comentário formatado para ser exibido ao usuário
class CommentUi {
  /// Identificador único da postagem que o comentário pertence.
  final int postId;

  /// Identificador único do comentário.
  final int commentId;

  /// Identificador único do usuário que fez o comentário.
  final UuidValue userId;

  /// Url da foto de perfil do usuário.
  final String? avatarUrl;

  /// Nome do autor do comentário.
  final String userName;

  /// Conteúdo do comentário.
  final String text;

  /// URL da imagem anexada ao comentário.
  final String? imageUrl;

  /// URL do vídeo anexado ao comentário.
  final String? videoUrl;

  /// Há quanto tempo o comentário foi enviado.
  ///
  /// Ex: há 4h.
  final String timeSinceCommented;

  /// Há quanto tempo o comentário foi editado.
  final String? timeSinceEdited;

  /// Horário que o comentário foi enviado.
  final String formattedCommentedTime;

  CommentUi({
    required this.postId,
    required this.commentId,
    required this.userId,
    this.avatarUrl,
    required this.userName,
    required this.text,
    this.imageUrl,
    this.videoUrl,
    required this.timeSinceCommented,
    this.timeSinceEdited,
    required this.formattedCommentedTime,
  });
}
