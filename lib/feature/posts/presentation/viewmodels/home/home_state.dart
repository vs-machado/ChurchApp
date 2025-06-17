import 'package:church_app/feature/posts/presentation/models/post_ui.dart';

sealed class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeError extends HomeState {
  final String message;

  HomeError(this.message);
}

class AllPostsLoaded extends HomeState {}

class HomeSuccess extends HomeState {}
