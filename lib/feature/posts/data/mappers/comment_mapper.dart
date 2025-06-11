import 'package:uuid/uuid_value.dart';

import '../../domain/comment.dart';
import '../networking/dto/comment_dto.dart';

/// Mapeia um CommentDto para Comment
extension CommentDtoX on CommentDto {
  Comment toComment() {
    return Comment(
      postId: postId,
      commentId: commentId,
      userId: UuidValue.fromString(userId),
      avatarUrl: avatarUrl,
      userName: userName,
      text: text,
      imageUrl: imageUrl,
      videoUrl: videoUrl,
      createdAt: DateTime.parse(createdAt),
      editedAt: editedAt == null ? null : DateTime.parse(editedAt!),
    );
  }
}
