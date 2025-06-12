import 'package:church_app/feature/posts/di/providers.dart';
import 'package:church_app/feature/posts/presentation/components/comment_item.dart';
import 'package:church_app/feature/posts/presentation/components/post_item.dart';
import 'package:church_app/feature/posts/presentation/viewmodels/post_details/post_details_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../generated/l10n.dart';
import '../models/post_ui.dart';

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

    // // Chama o fetching dos comentários apenas uma vez
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   if (!_initialFetchDone) {
    //     final state = ref.read(postDetailsViewModelProvider);
    //     if (state is Initial) {
    //       ref
    //           .read(postDetailsViewModelProvider.notifier)
    //           .fetchComments(widget.post.id);
    //     }
    //     _initialFetchDone = true;
    //   }
    // });

    // Chama o fetching dos comentários
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final state = ref.watch(provider);
      final viewModel = ref.read(provider.notifier);

      if (state is Initial) {
        viewModel.fetchComments(widget.post.id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(provider);

    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).postDetails)),
      body: SafeArea(
        child: _buildBody(state, context, widget.post, _controller),
      ),
      resizeToAvoidBottomInset:
          true, // Garante que o teclado não cubra o TextField
    );
  }
}

Widget _buildBody(
  PostDetailsState state,
  BuildContext context,
  PostUi post,
  TextEditingController controller,
) {
  return switch (state) {
    Initial() => Column(
      children: [
        Expanded(child: SingleChildScrollView(child: PostItem(post: post))),
        _buildCommentTextField(context, controller),
      ],
    ),
    Loading() => Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                PostItem(post: post),
                const SizedBox(height: 16),
                const Center(child: CircularProgressIndicator()),
              ],
            ),
          ),
        ),
        _buildCommentTextField(context, controller),
      ],
    ),
    Success(comments: final comments) => Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                PostItem(post: post),
                const SizedBox(height: 16),
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
        _buildCommentTextField(context, controller),
      ],
    ),
    DetailsError(message: final message) => Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                PostItem(post: post),
                const SizedBox(height: 16),
                Center(
                  child: Text(
                    message,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        _buildCommentTextField(context, controller),
      ],
    ),
  };
}

Widget _buildCommentTextField(
  BuildContext context,
  TextEditingController controller,
) {
  return Container(
    padding: const EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      color: Theme.of(context).scaffoldBackgroundColor,
      border: Border(top: BorderSide(color: Colors.grey.shade300, width: 0.5)),
    ),
    child: TextField(
      controller: controller,
      onSubmitted: (_) => () {} /*sendMessage()*/,
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
        suffixIcon: IconButton(
          icon: const Icon(Icons.send_outlined),
          onPressed: () {} /*sendMessage*/,
        ),
      ),
    ),
  );
}
