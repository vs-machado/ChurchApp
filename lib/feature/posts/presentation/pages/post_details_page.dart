import 'package:church_app/feature/posts/di/providers.dart';
import 'package:church_app/feature/posts/presentation/components/comment_item.dart';
import 'package:church_app/feature/posts/presentation/components/post_item.dart';
import 'package:church_app/feature/posts/presentation/viewmodels/post_details/post_details_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../../../generated/l10n.dart';
import '../models/comment_ui.dart';
import '../models/post_ui.dart';
import '../viewmodels/post_details/post_details_viewmodel.dart';

/// Exibe a postagem detalhada e os comentários abaixo.
///
/// Utiliza a biblioteca infinite_scroll_pagination para a paginação dos comentários.
class PostDetailsPage extends ConsumerStatefulWidget {
  final PostUi post;

  const PostDetailsPage({super.key, required this.post});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PostDetailsPageState();
}

class _PostDetailsPageState extends ConsumerState<PostDetailsPage> {
  final TextEditingController _controller = TextEditingController();
  FocusNode _commentFocusNode = FocusNode();

  late final provider = postDetailsViewModelProvider(widget.post.id);

  late final _pagingController = PagingController<int, CommentUi>(
    getNextPageKey: (state) => (state.keys?.last ?? 0) + 1,
    fetchPage: (pageKey) => ref.watch(provider.notifier).fetchComments(pageKey),
  );

  // // TODO: desativar antes de commitar
  // bool _initialFetchDone = false; // desativa o fetching durante hot reload

  void _focusCommentField() {
    _commentFocusNode.requestFocus();
  }

  @override
  void dispose() {
    _controller.dispose();
    _pagingController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    // Adia a chamada para depois que o primeiro frame for renderizado
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        ref.read(provider.notifier).resetCommentsState();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(provider);
    final viewModel = ref.watch(provider.notifier);

    // Verifica se deve focar o campo de comentário na abertura da página
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is Map<String, dynamic> && args['focusComment'] == true) {
      // Focaliza após a renderização
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _focusCommentField();
      });
    }

    // Quando todos os comentários forem carregados, atualiza o estado do pagingstate
    // para evitar a exibição do CircularProgressIndicator e a chamada do fetching.
    ref.listen<PostDetailsState>(provider, (previous, next) {
      if (ref.watch(provider.notifier).allCommentsLoaded) {
        _pagingController.value = _pagingController.value.copyWith(
          hasNextPage: false,
          isLoading: false,
        );
      }
    });

    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).postDetails)),
      body: SafeArea(child: _buildBody(context, state, widget.post, viewModel)),
      resizeToAvoidBottomInset:
          true, // Garante que o teclado não cubra o TextField
    );
  }

  /// Exibe a UI de acordo com o estado atual
  Widget _buildBody(
    BuildContext context,
    PostDetailsState state,
    PostUi post,
    PostDetailsViewModel viewModel,
  ) {
    final isPosting = state is PostingComment;

    return Column(
      children: [
        Expanded(
          child: RefreshIndicator(
            onRefresh:
                () => Future.sync(() {
                  viewModel.resetCommentsState();
                  _pagingController.refresh();
                }),
            child: CustomScrollView(
              slivers: [
                // Exibe o post
                SliverToBoxAdapter(child: PostItem(post: post)),
                //Exibe a lista de comentários
                PagingListener(
                  controller: _pagingController,
                  builder:
                      (context, state, fetchNextPage) =>
                          PagedSliverList<int, CommentUi>(
                            state: state,
                            fetchNextPage: fetchNextPage,
                            builderDelegate: PagedChildBuilderDelegate(
                              itemBuilder:
                                  (context, item, index) => CommentItem(
                                    key: ValueKey(item.commentId),
                                    comment: item,
                                  ),
                              noItemsFoundIndicatorBuilder: (_) => Text(""),
                            ),
                          ),
                ),
              ],
            ),
          ),
        ),

        _buildCommentTextField(context, viewModel, isPosting),
      ],
    );
  }

  /// Textfield com botão de envio
  Widget _buildCommentTextField(
    BuildContext context,
    PostDetailsViewModel viewModel,
    bool isSending,
  ) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        border: Border(
          top: BorderSide(color: Colors.grey.shade300, width: 0.5),
        ),
      ),
      child: Row(
        children: [
          // Campo de texto multiline
          Expanded(
            child: TextField(
              controller: _controller,
              focusNode: _commentFocusNode,
              keyboardType: TextInputType.multiline,
              textInputAction: TextInputAction.newline,
              maxLines: null,
              decoration: InputDecoration(
                hintText: S.of(context).leaveAComment,
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 12.0,
                ),
              ),
            ),
          ),

          // Botão de envio (ou loading durante envio)
          IconButton(
            icon:
                isSending
                    ? const SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                    : const Icon(Icons.send_outlined),
            onPressed:
                isSending
                    ? null
                    : () async {
                      final text = _controller.text.trim();
                      if (text.isNotEmpty) {
                        await viewModel.sendComment(widget.post.id, text);
                        _controller.clear(); // Limpa o campo após envio
                      }

                      _pagingController.refresh();
                    },
          ),
        ],
      ),
    );
  }
}
