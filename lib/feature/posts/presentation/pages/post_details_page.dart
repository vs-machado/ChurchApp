import 'package:church_app/feature/posts/di/providers.dart';
import 'package:church_app/feature/posts/presentation/components/comment_item.dart';
import 'package:church_app/feature/posts/presentation/components/post_item.dart';
import 'package:church_app/feature/posts/presentation/viewmodels/post_details/post_details_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../generated/l10n.dart';
import '../models/comment_ui.dart';
import '../models/post_ui.dart';
import '../viewmodels/post_details/post_details_viewmodel.dart';

class PostDetailsPage extends ConsumerStatefulWidget {
  final PostUi post;

  const PostDetailsPage({super.key, required this.post});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PostDetailsPageState();
}

class _PostDetailsPageState extends ConsumerState<PostDetailsPage> {
  final TextEditingController _controller = TextEditingController();
  late final provider = postDetailsViewModelProvider(widget.post.id);

  // // TODO: desativar antes de commitar
  // bool _initialFetchDone = false; // desativa o fetching durante hot reload

  @override
  void initState() {
    super.initState();

    // Chama o fetching dos comentários
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final state = ref.read(provider);
      if (state is Initial) {
        ref.read(provider.notifier).fetchComments(widget.post.id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(provider);
    final viewModel = ref.watch(provider.notifier);

    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).postDetails)),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => viewModel.fetchComments(widget.post.id),
          child: _buildBody(context, state, widget.post, viewModel),
        ),
      ),
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
    // Extrai os comentários a serem exibidos
    final comments = switch (state) {
      Success(:final comments) => comments,
      PostingComment(:final comments) => comments,
      _ => <CommentUi>[],
    };

    final isLoading = state is Loading;
    final isPosting = state is PostingComment;

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                // Exibe o post
                PostItem(post: post),

                // Exibe mensagem de erro (caso necessário)
                if (state is DetailsError)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Text(
                      state.message,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                  ),

                // Exibe o loading (caso necessário)
                if (isLoading)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Center(child: CircularProgressIndicator()),
                  ),

                // Exibe a lista de comentários
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: comments.length,
                  itemBuilder:
                      (context, index) => CommentItem(comment: comments[index]),
                ),
              ],
            ),
          ),
        ),

        // Textfield do comentário
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
                    },
          ),
        ],
      ),
    );
  }
}
