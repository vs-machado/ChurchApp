import 'package:church_app/feature/posts/domain/post.dart';

import 'comment.dart';

/// Interface para acesso aos dados de postagens
abstract class RemoteDataSource {
  /// Retorna uma lista de postagens a serem exibidas no feed
  ///
  /// [limit] Quantidade de posts a serem retornados
  /// [offset] A partir de qual post da tabela começar a retornar os resultados
  Future<List<Post>> getPosts({int limit = 20, int offset = 0});

  /// Retorna os comentários da postagem selecionada
  ///
  /// [postId] Id da postagem
  /// [limit] Quantidade de comentários a serem retornados
  /// [offset] A partir de qual comentário da tabela começar a retornar os resultados
  Future<List<Comment>> getComments(
    int postId, {
    int limit = 20,
    int offset = 0,
  });

  /// Envia o comentário do usuário para o banco de dados
  ///
  /// [postId] Id da postagem
  /// [comment] Comentário a ser enviado
  Future<void> sendComment(
    int postId,
    String comment,
    String? imageUrl,
    String? videoUrl,
  );
}
