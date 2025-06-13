import 'package:church_app/feature/posts/domain/remote_data_source.dart';
import 'package:church_app/feature/posts/presentation/mappers/comment_presentation_mapper.dart';
import 'package:church_app/feature/posts/presentation/viewmodels/post_details/post_details_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ntp/ntp.dart';

///  Carrega os comentários do post selecionado.
///  Em caso de falha, exibe um erro.
class PostDetailsViewModel extends StateNotifier<PostDetailsState> {
  final RemoteDataSource _remoteDataSource;
  final int postId;

  PostDetailsViewModel({
    required RemoteDataSource remoteDataSource,
    required this.postId,
  }) : _remoteDataSource = remoteDataSource,
       super(Initial());

  /// Realiza o fetching dos comentários do post selecionado.
  ///
  /// Utiliza o [postId] para a query e exibe ao usuário os resultados.
  Future<void> fetchComments(int postId) async {
    try {
      state = Loading();

      final comments = await _remoteDataSource.getComments(postId);
      debugPrint('Comentários recebidos: ${comments.length}');
      for (var comment in comments) {
        debugPrint(
          'Comentário: id=${comment.commentId}, texto=${comment.text}, usuário=${comment.user.name}',
        );
      }

      // Tenta obter o horário através do protocolo NTP.
      // Caso não haja internet, usa o horário do celular do usuário.
      DateTime? currentTime;
      try {
        currentTime = await NTP.now();
      } catch (e) {
        currentTime = null;
      }

      final commentsUi =
          comments.map((comment) => comment.toUi(currentTime)).toList();
      state = Success(commentsUi);
    } catch (e) {
      state = DetailsError('Failed to fetch comments: ${e.toString()}');
    }
  }

  /// Envia o comentário do usuário para o banco de dados e atualiza os comentários postados na tela.
  ///
  /// O [comment], [imageUrl] e [videoUrl] são enviados através de um insert que contém o [postId].
  Future<void> sendComment(
    int postId,
    String comment, {
    String? imageUrl,
    String? videoUrl,
  }) async {
    final currentState = state;

    if (currentState is Success) {
      try {
        state = PostingComment(currentState.comments);
        await _remoteDataSource.sendComment(
          postId,
          comment,
          imageUrl,
          videoUrl,
        );
        await fetchComments(postId);
      } catch (e) {
        state = DetailsError('Failed to send comment: ${e.toString()}');
      }
    }
  }
}
