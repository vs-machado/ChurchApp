/// Recebe os dados de uma postagem do banco de dados
class PostDto {
  /// Identificador único da postagem.
  final String id;

  /// Identificador único do usuário.
  final String userId;

  /// Data de criação da postagem.
  final String createdAt;

  /// Data de edição da postagem.
  final String? editedAt;

  /// Conteúdo da postagem.
  final String text;
  final String? photoUrl;
  final String? videoUrl;

  /// Quantidade de likes da postagem.
  final int likesCount;

  PostDto({
    required this.id,
    required this.userId,
    required this.createdAt,
    this.editedAt,
    required this.text,
    this.photoUrl,
    this.videoUrl,
    required this.likesCount,
  });

  factory PostDto.fromJson(Map<String, dynamic> json) {
    return PostDto(
      id: json['id'],
      userId: json['user_id'],
      createdAt: json['created_at'],
      editedAt: json['edited_at'],
      text: json['text'],
      photoUrl: json['photo_url'],
      videoUrl: json['video_url'],
      likesCount: json['likes_count'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'created_at': createdAt,
      'edited_at': editedAt,
      'text': text,
      'photo_url': photoUrl,
      'video_url': videoUrl,
      'likes_count': likesCount,
    };
  }
}
