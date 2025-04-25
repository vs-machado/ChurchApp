class HomeState {
  final bool isLoading;
  final bool isSuccess;
  final String? errorMessage;
  // final List<PostUi> posts;

  HomeState({
    this.isLoading = false,
    this.isSuccess = false,
    this.errorMessage,
  });

  HomeState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? errorMessage,
    // List<PostUi>? posts
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage ?? this.errorMessage,
      // posts: posts ?? this.posts,
    );
  }
}