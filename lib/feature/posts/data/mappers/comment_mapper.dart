import 'package:uuid/uuid_value.dart';

import '../../../../core/domain/value_objects/user.dart';
import '../../domain/comment.dart';
import '../networking/dto/comment_dto.dart';

/// Mapeia um CommentDto para Comment
extension CommentDtoX on CommentDto {
  Comment toComment() {
    return Comment(
      postId: postId,
      commentId: commentId,
      user: User(
        id: UuidValue.fromString(userId),
        name: userName,
        avatarUrl: avatarUrl,
      ),
      text: text,
      imageUrl: imageUrl,
      videoUrl: videoUrl,
      createdAt: DateTime.parse(createdAt),
      editedAt: editedAt == null ? null : DateTime.parse(editedAt!),
    );
  }
}
