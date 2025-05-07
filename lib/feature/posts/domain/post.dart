import 'package:uuid/uuid.dart';

/// Representa uma postagem na camada de domínio da aplicação
class Post {
  /// Identificador único da postagem.
  final Uuid id;

  /// Identificador único do usuário.
  final String userId;

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
    required this.userId,
    required this.createdAt,
    this.editedAt,
    required this.text,
    this.photoUrl,
    this.videoUrl,
    required this.likesCount,
  });
}
