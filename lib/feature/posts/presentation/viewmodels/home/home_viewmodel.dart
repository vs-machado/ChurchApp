import 'package:church_app/core/auth/domain/auth_service.dart';
import 'package:church_app/feature/posts/presentation/mappers/post_presentation_mapper.dart';
import 'package:church_app/feature/posts/presentation/viewmodels/home/home_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:ntp/ntp.dart';
import 'package:timeago/timeago.dart' as timeAgo;

import '../../../domain/remote_data_source.dart';
import '../../models/post_ui.dart';

class HomeViewModel extends StateNotifier<HomeState> {
  final AuthService _authService;
  final RemoteDataSource _postDataSource;

  int _offset = 0;
  bool allPostsLoaded = false;

  HomeViewModel({
    required AuthService authService,
    required RemoteDataSource remoteDataSource,
  }) : _authService = authService,
       _postDataSource = remoteDataSource,
       super(HomeInitial());

  void logout() {
    _authService.signOut();
  }

  /// Chama o fetching dos posts e converte os objetos para a classe PostUi.
  ///
  /// Quando utiliza o Network Time Protocol para exibir ao usuário há quanto tempo atrás
  /// o conteúdo foi postado. Utilizado para evitar que o usuário altere a data do dispositivo,
  /// resultando em cálculos inconsistentes.
  ///
  /// Quando o currentTime é null (usuário sem internet), [DateTime.now] é utilizado. Para mais detalhes, ver [timeAgo.format].
  Future<List<PostUi>> fetchPosts(int pageKey, {int limit = 10}) async {
    if (allPostsLoaded) {
      state = AllPostsLoaded();
      return [];
    }

    _offset = (pageKey - 1) * limit;
    try {
      final posts = await _postDataSource.getPosts(
        offset: _offset,
        limit: limit,
      );

      DateTime? currentTime;
      try {
        currentTime = await NTP.now();
      } catch (e) {
        currentTime = null;
      }

      if (posts.isEmpty || posts.length < limit) allPostsLoaded = true;

      final postsUi = posts.map((post) => post.toUi(currentTime)).toList();
      return postsUi;
    } catch (e) {
      state = HomeError('Failed to fetch posts: ${e.toString()}');
      return [];
    }
  }

  void resetPostsState() {
    allPostsLoaded = false;
    state = HomeInitial();
  }
}
