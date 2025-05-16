import 'package:church_app/feature/posts/di/providers.dart';
import 'package:church_app/feature/posts/presentation/viewmodels/home/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../generated/l10n.dart';
import '../components/post_item.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homeViewModelProvider);

    ref.listen(homeViewModelProvider, (previous, current) {
      if (current is HomeError) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(current.message)));
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (state is HomeInitial) {
        ref.read(homeViewModelProvider.notifier).fetchPosts();
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).homePage),
        actions: [
          IconButton(
            onPressed: () => ref.read(homeViewModelProvider.notifier).logout(),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: _buildBody(state, context),
    );
  }

  Widget _buildBody(HomeState state, BuildContext context) {
    return switch (state) {
      HomeInitial() => Center(child: Text(S.of(context).welcome)),
      HomeLoading() => const Center(child: CircularProgressIndicator()),
      HomeSuccess() => ListView.separated(
        itemCount: state.posts.length,
        itemBuilder: (context, index) {
          final post = state.posts[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: PostItem(post: post),
          );
        },
        separatorBuilder: (context, index) => const Divider(height: 4.0),
      ),
      HomeError() => Center(child: Text(S.of(context).anErrorOccurred)),
    };
  }
}
