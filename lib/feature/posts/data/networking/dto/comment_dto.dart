/// Recebe os dados de um comentário de uma postagem.
class CommentDto {
  /// Identificador único do comentário.
  final int id;

  /// Identificador único da postagem que o comentário pertence.
  final int postId;

  /// Identificador único do usuário que fez o comentário.
  final String userId;

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
    required this.id,
    required this.postId,
    required this.userId,
    required this.text,
    this.imageUrl,
    this.videoUrl,
    required this.createdAt,
    this.editedAt,
  });

  factory CommentDto.fromJson(Map<String, dynamic> json) {
    return CommentDto(
      id: json['id'] as int,
      postId: json['post_id'] as int,
      userId: json['user_id'] as String,
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
      'id': id,
      'post_id': postId,
      'user_id': userId,
      'text': text,
      'image_url': imageUrl,
      'video_url': videoUrl,
      'created_at': createdAt.toIso8601String(),
      'edited_at': editedAt?.toIso8601String(),
    };
  }
}
