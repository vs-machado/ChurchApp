/// Recebe os dados dos posts do banco de dados
class PostDto {
  /// Identificador único do post.
  final String id;

  /// Identificador único do usuário.
  final String userId;

  /// Data de criação do post.
  final String createdAt;

  /// Data de edição do post.
  final String? editedAt;

  /// Conteúdo do post.
  final String text;
  final String? photoUrl;
  final String? videoUrl;

  /// Quantidade de likes do post.
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
}
