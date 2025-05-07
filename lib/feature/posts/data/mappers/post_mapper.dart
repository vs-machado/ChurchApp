import 'package:uuid/uuid.dart';

import '../../domain/post.dart';
import '../networking/dto/post_dto.dart';

/// Classe responsável por mapear entre Post (domain) e PostDto (data)
class PostMapper {
  /// Converte um PostDto para um objeto Post do domain
  static Post fromDto(PostDto dto) {
    return Post(
      id: int.parse(dto.id),
      userId: UuidValue.fromString(dto.userId),
      createdAt: DateTime.parse(dto.createdAt),
      editedAt: dto.editedAt != null ? DateTime.parse(dto.editedAt!) : null,
      text: dto.text,
      photoUrl: dto.photoUrl,
      videoUrl: dto.videoUrl,
      likesCount: dto.likesCount,
    );
  }

  /// Converte um objeto Post do domain para um PostDto
  static PostDto toDto(Post post) {
    return PostDto(
      id: post.id.toString(),
      userId: post.userId.toString(),
      createdAt: post.createdAt.toIso8601String(),
      editedAt: post.editedAt?.toIso8601String(),
      text: post.text,
      photoUrl: post.photoUrl,
      videoUrl: post.videoUrl,
      likesCount: post.likesCount,
    );
  }
}
