import 'package:uuid/uuid.dart';

import '../../../../core/domain/value_objects/user.dart';
import '../../domain/post.dart';
import '../networking/dto/post_dto.dart';

/// Extension functions para mapear entre Post (domain) e PostDto (data)
extension PostDtoX on PostDto {
  /// Converte um PostDto para um objeto Post do domain
  Post toPost() {
    return Post(
      id: id,
      user: User(
        id: UuidValue.fromString(userId),
        name: userName,
        avatarUrl: userAvatarUrl,
      ),
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
      id: id,
      userId: user.id.toString(),
      userName: user.name,
      userAvatarUrl: user.avatarUrl,
      createdAt: createdAt.toIso8601String(),
      editedAt: editedAt?.toIso8601String(),
      text: text,
      photoUrl: photoUrl,
      videoUrl: videoUrl,
      likesCount: likesCount,
    );
  }
}
