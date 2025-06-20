import '../../../core/domain/value_objects/user.dart';

/// Representa uma postagem na camada de domínio da aplicação
class Post {
  /// Identificador único da postagem.
  final int id;

  /// Usuário que criou a postagem.
  final User user;

  /// Data de criação da postagem.
  final DateTime createdAt;

  /// Data de edição da postagem.
  final DateTime? editedAt;

  /// Conteúdo da postagem.
  final String text;

  /// URL da imagem anexada ao post, se houver.
  final String? photoUrl;

  /// URL do vídeo anexado ao post, se houver.
  final String? videoUrl;

  /// Quantidade de likes da postagem.
  final int likesCount;

  Post({
    required this.id,
    required this.user,
    required this.createdAt,
    this.editedAt,
    required this.text,
    this.photoUrl,
    this.videoUrl,
    required this.likesCount,
  });
}
