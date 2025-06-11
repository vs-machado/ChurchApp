import 'package:uuid/uuid_value.dart';

import '../../../../core/domain/value_objects/user.dart';

/// Comentário formatado para ser exibido ao usuário
class CommentUi {
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
    required this.user,
    required this.text,
    this.imageUrl,
    this.videoUrl,
    required this.timeSinceCommented,
    this.timeSinceEdited,
    required this.formattedCommentedTime,
  });
}
