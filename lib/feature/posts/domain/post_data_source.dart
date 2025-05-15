import 'package:church_app/feature/posts/domain/post.dart';

/// Interface para acesso aos dados de postagens
abstract class PostDataSource {
  /// Retorna uma lista de postagens a serem exibidas no feed
  Future<List<Post>> getPosts();
}
