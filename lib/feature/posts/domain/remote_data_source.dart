import 'package:church_app/feature/posts/domain/post.dart';

import 'comment.dart';

/// Interface para acesso aos dados de postagens
abstract class RemoteDataSource {
  /// Retorna uma lista de postagens a serem exibidas no feed
  Future<List<Post>> getPosts({int limit = 20, int offset = 0});

  /// Retorna os comentários da postagem selecionada
  Future<List<Comment>> getComments(
    int postId, {
    int limit = 20,
    int offset = 0,
  });
}
