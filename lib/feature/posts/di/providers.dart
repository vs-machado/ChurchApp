import 'package:church_app/core/di/providers.dart';
import 'package:church_app/feature/posts/presentation/viewmodels/home/home_state.dart';
import 'package:church_app/feature/posts/presentation/viewmodels/home/home_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/networking/remote_post_data_source.dart';
import '../domain/post_data_source.dart';

final homeViewModelProvider = StateNotifierProvider<HomeViewModel, HomeState>((
  ref,
) {
  final authService = ref.watch(authServiceProvider);
  final postDataSource = ref.watch(postDataSourceProvider);
  return HomeViewModel(
    authService: authService,
    postDataSource: postDataSource,
  );
});

final postDataSourceProvider = Provider<PostDataSource>((ref) {
  final supabaseClient = ref.watch(supabaseClientProvider);
  return RemotePostDataSource(supabaseClient: supabaseClient);
});
