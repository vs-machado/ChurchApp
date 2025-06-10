/// Recebe os dados de um comentário de uma postagem.
class CommentDto {
  /// Identificador único da postagem que o comentário pertence.
  final int postId;

  /// Identificador único do comentário.
  final int commentId;

  /// Identificador único do usuário que fez o comentário.
  final String userId;

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

  /// Data e hora em que o comentário foi criado.
  final DateTime createdAt;

  /// Data e hora em que o comentário foi editado pela última vez.
  final DateTime? editedAt;

  CommentDto({
    required this.postId,
    required this.commentId,
    required this.userId,
    this.avatarUrl,
    required this.userName,
    required this.text,
    this.imageUrl,
    this.videoUrl,
    required this.createdAt,
    this.editedAt,
  });

  factory CommentDto.fromJson(Map<String, dynamic> json) {
    return CommentDto(
      postId: json['post_id'] as int,
      commentId: json['comment_id'] as int,
      userId: json['user_id'] as String,
      avatarUrl: json['avatar_url'] as String?,
      userName: json['user_name'] as String,
      text: json['text'] as String,
      imageUrl: json['image_url'] as String?,
      videoUrl: json['video_url'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      editedAt:
          json['edited_at'] == null
              ? null
              : DateTime.parse(json['edited_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'post_id': postId,
      'comment_id': commentId,
      'user_id': userId,
      'avatar_url': avatarUrl,
      'user_name': userName,
      'text': text,
      'image_url': imageUrl,
      'video_url': videoUrl,
      'created_at': createdAt.toIso8601String(),
      'edited_at': editedAt?.toIso8601String(),
    };
  }
}
