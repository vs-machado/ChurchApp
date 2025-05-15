import 'package:uuid/uuid.dart';

import '../../domain/post.dart';
import '../networking/dto/post_dto.dart';

/// Extension functions para mapear entre Post (domain) e PostDto (data)
extension PostDtoX on PostDto {
  /// Converte um PostDto para um objeto Post do domain
  Post toPost() {
    return Post(
      id: int.parse(id),
      userId: UuidValue.fromString(userId),
      userName: userName,
      userAvatarUrl: userAvatarUrl,
      createdAt: DateTime.parse(createdAt),
      editedAt: editedAt != null ? DateTime.parse(editedAt!) : null,
      text: text,
      photoUrl: photoUrl,
      videoUrl: videoUrl,
      likesCount: likesCount,
    );
  }
}

extension PostX on Post {
  /// Converte um objeto Post do domain para um PostDto
  PostDto toDto() {
    return PostDto(
      id: id.toString(),
      userId: userId.toString(),
      userName: userName,
      userAvatarUrl: userAvatarUrl,
      createdAt: createdAt.toIso8601String(),
      editedAt: editedAt?.toIso8601String(),
      text: text,
      photoUrl: photoUrl,
      videoUrl: videoUrl,
      likesCount: likesCount,
    );
  }
}
