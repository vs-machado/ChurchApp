sealed class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeError extends HomeState {
  final String message;

  HomeError(this.message);
}

class HomeSuccess extends HomeState {
  // final List<PostUi> posts;
  // HomeSuccess(this.posts);
}