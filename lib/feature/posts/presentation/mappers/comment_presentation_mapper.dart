import 'package:church_app/feature/posts/presentation/utils/time_formatter.dart';

import '../../domain/comment.dart';
import '../models/comment_ui.dart';

extension CommentToUi on Comment {
  CommentUi toUi(DateTime? ntpTime) {
    final timeInfo = TimeFormatter.getContentTimeInfo(
      createdAt,
      editedAt: editedAt,
      ntpTime: ntpTime,
    );

    return CommentUi(
      postId: postId,
      commentId: commentId,
      userId: userId,
      avatarUrl: avatarUrl,
      userName: userName,
      text: text,
      imageUrl: imageUrl,
      videoUrl: videoUrl,
      timeSinceCommented: timeInfo.timeSinceCreated,
      timeSinceEdited: timeInfo.timeSinceEdited,
      formattedCommentedTime: timeInfo.formattedCreatedTime,
    );
  }
}
