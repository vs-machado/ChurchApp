import 'package:church_app/feature/posts/presentation/models/comment_ui.dart';

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
