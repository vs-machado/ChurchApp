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
    final samplePosts = List.generate(
      5,
      (index) => {
        'avatarUrl': null,
        'imageUrl': 'https://picsum.photos/seed/${index + 1}/400/300',
        'username': 'User ${index + 1}',
        'timeAgo': ' ${index + 1}h ago',
        'postText':
            'This is sample post number ${index + 1}. Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      },
    );

    return switch (state) {
      HomeInitial() => Center(child: Text(S.of(context).welcome)),
      HomeLoading() => const Center(child: CircularProgressIndicator()),
      HomeSuccess() => ListView.separated(
        itemCount: samplePosts.length,
        itemBuilder: (context, index) {
          final post = samplePosts[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: PostItem(
              avatarUrl: post['avatarUrl'],
              imageUrl: post['imageUrl'],
            ),
          );
        },
        separatorBuilder: (context, index) => const Divider(height: 4.0),
      ),
      HomeError() => Center(child: Text(S.of(context).anErrorOccurred)),
    };
  }
}
