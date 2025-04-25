import 'package:church_app/feature/posts/di/providers.dart';
import 'package:church_app/feature/posts/presentation/viewmodels/home/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../generated/l10n.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(homeViewModelProvider.notifier);
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
            onPressed: viewModel.logout,
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
      HomeSuccess() => Center(child: Text(S.of(context).postsLoaded)),
      HomeError() => Center(child: Text(S.of(context).anErrorOccurred)),
    };
  }
}
