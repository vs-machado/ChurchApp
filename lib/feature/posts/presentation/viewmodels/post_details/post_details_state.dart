import '../../models/comment_ui.dart';

sealed class PostDetailsState {}

class Initial extends PostDetailsState {}

class Loading extends PostDetailsState {}

class DetailsError extends PostDetailsState {
  final String message;

  DetailsError(this.message);
}

class Success extends PostDetailsState {
  final List<CommentUi> comments;

  Success(this.comments);
}

class PostingComment extends PostDetailsState {
  final List<CommentUi> comments;

  PostingComment(this.comments);
}
