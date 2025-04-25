import 'package:church_app/feature/posts/di/providers.dart';
import 'package:church_app/feature/posts/presentation/viewmodels/home/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(homeViewModelProvider.notifier);
    final state = ref.watch(homeViewModelProvider);

    ref.listen(homeViewModelProvider, (previous, current) {
      if (current is HomeError) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(current.message))
        );
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text("Página inicial"),
        actions: [
          IconButton(
            onPressed: viewModel.logout,
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: _buildBody(state),
    );
  }

  Widget _buildBody(HomeState state) {
    return switch(state) {
      HomeInitial() => const Center(child: Text("Bem-vindo!")),
      HomeLoading() => const Center(child: CircularProgressIndicator()),
      HomeSuccess() => const Center(child: Text("Posts carregados!")),
      HomeError() =>
      const Center(child: Text("Ocorreu um erro. Tente novamente.")),
    };
  }
}