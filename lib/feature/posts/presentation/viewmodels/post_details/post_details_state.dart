import '../../models/comment_ui.dart';

sealed class PostDetailsState {}

class Initial extends PostDetailsState {}

class DetailsError extends PostDetailsState {
  final String message;

  DetailsError(this.message);
}

class PostingComment extends PostDetailsState {
  final List<CommentUi> comments;

  PostingComment(this.comments);
}

class CommentsLoaded extends PostDetailsState {
  final bool allCommentsLoaded;

  CommentsLoaded(this.allCommentsLoaded);
}
