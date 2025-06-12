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

  /// Realiza o fetching dos comentários do post selecionado e exibe ao usuário
  ///
  /// [postId] Id do post a carregar os comentários
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
}
