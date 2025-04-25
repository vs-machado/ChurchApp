import 'package:church_app/feature/posts/di/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.read(homeViewModelProvider.notifier);
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
    );
  }
}