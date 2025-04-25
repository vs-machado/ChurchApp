import 'package:church_app/core/di/providers.dart';
import 'package:church_app/feature/posts/presentation/viewmodels/home/home_state.dart';
import 'package:church_app/feature/posts/presentation/viewmodels/home/home_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeViewModelProvider = StateNotifierProvider<HomeViewModel, HomeState>((ref) {
  final authService = ref.watch(authServiceProvider);
  return HomeViewModel(authService: authService);
});