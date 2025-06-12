import 'package:church_app/core/di/providers.dart';
import 'package:church_app/feature/posts/presentation/viewmodels/home/home_state.dart';
import 'package:church_app/feature/posts/presentation/viewmodels/home/home_viewmodel.dart';
import 'package:church_app/feature/posts/presentation/viewmodels/post_details/post_details_state.dart';
import 'package:church_app/feature/posts/presentation/viewmodels/post_details/post_details_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/networking/remote_data_source_impl.dart';
import '../domain/remote_data_source.dart';

final homeViewModelProvider = StateNotifierProvider<HomeViewModel, HomeState>((
  ref,
) {
  final authService = ref.watch(authServiceProvider);
  final remoteDataSource = ref.watch(remoteDataSourceProvider);
  return HomeViewModel(
    authService: authService,
    remoteDataSource: remoteDataSource,
  );
});

final postDetailsViewModelProvider =
    StateNotifierProvider.family<PostDetailsViewModel, PostDetailsState, int>((
      ref,
      postId,
    ) {
      final remoteDataSource = ref.watch(remoteDataSourceProvider);
      return PostDetailsViewModel(
        remoteDataSource: remoteDataSource,
        postId: postId,
      );
    });

final remoteDataSourceProvider = Provider<RemoteDataSource>((ref) {
  final supabaseClient = ref.watch(supabaseClientProvider);
  return RemoteDataSourceImpl(supabaseClient: supabaseClient);
});
