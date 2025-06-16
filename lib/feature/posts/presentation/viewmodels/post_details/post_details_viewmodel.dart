import 'package:church_app/feature/posts/domain/remote_data_source.dart';
import 'package:church_app/feature/posts/presentation/mappers/comment_presentation_mapper.dart';
import 'package:church_app/feature/posts/presentation/viewmodels/post_details/post_details_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ntp/ntp.dart';

import '../../models/comment_ui.dart';

///  Carrega os comentários do post selecionado.
///  Em caso de falha, exibe um erro.
class PostDetailsViewModel extends StateNotifier<PostDetailsState> {
  final RemoteDataSource _remoteDataSource;
  final int postId;

  int _offset = 0;
  bool allCommentsLoaded = false;

  PostDetailsViewModel({
    required RemoteDataSource remoteDataSource,
    required this.postId,
  }) : _remoteDataSource = remoteDataSource,
       super(Initial());

  /// Realiza o fetching dos comentários do post selecionado.
  ///
  /// Utiliza o [postId] para a query e exibe ao usuário os resultados.
  Future<List<CommentUi>> fetchComments(int pageKey, {int limit = 10}) async {
    if (allCommentsLoaded) {
      state = CommentsLoaded(true);
      return [];
    }

    _offset = (pageKey - 1) * limit;
    try {
      final comments = await _remoteDataSource.getComments(
        postId,
        limit: limit,
        offset: _offset,
      );
      debugPrint('Comentários recebidos: ${comments.length}, offset: $_offset');
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

      if (comments.isEmpty || comments.length < limit) {
        allCommentsLoaded = true;
      }

      final commentsUi =
          comments.map((comment) => comment.toUi(currentTime)).toList();
      return commentsUi;
    } catch (e) {
      return [];
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
    try {
      await _remoteDataSource.sendComment(postId, comment, imageUrl, videoUrl);

      // Reseta o estado para permitir nova busca
      allCommentsLoaded = false;
      _offset = 0;
    } catch (e) {
      state = DetailsError('Failed to send comment: ${e.toString()}');
    }
  }

  void resetCommentsState() {
    allCommentsLoaded = false;
    state = Initial();
  }
}
