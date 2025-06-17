import 'package:church_app/feature/posts/di/providers.dart';
import 'package:church_app/feature/posts/presentation/viewmodels/home/home_state.dart';
import 'package:church_app/feature/posts/presentation/viewmodels/home/home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../generated/l10n.dart';
import '../components/post_item.dart';
import '../models/post_ui.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  late final provider = homeViewModelProvider;

  late final _pagingController = PagingController<int, PostUi>(
    getNextPageKey: (state) => (state.keys?.last ?? 0) + 1,
    fetchPage: (pageKey) => ref.watch(provider.notifier).fetchPosts(pageKey),
  );

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(provider.notifier);

    ref.listen<HomeState>(provider, (previous, next) {
      if (viewModel.allPostsLoaded) {
        _pagingController.value = _pagingController.value.copyWith(
          hasNextPage: false,
          isLoading: false,
        );
      }
    });

    ref.listen(homeViewModelProvider, (previous, current) {
      if (current is HomeError) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(current.message)));
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        ref.read(provider.notifier).resetPostsState();
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
      body: _buildBody(context, viewModel),
    );
  }

  Widget _buildBody(BuildContext context, HomeViewModel viewModel) {
    return Column(
      children: [
        Expanded(
          child: RefreshIndicator(
            onRefresh:
                () => Future.sync(() {
                  viewModel.resetPostsState();
                  _pagingController.refresh();
                }),
            child: PagingListener(
              controller: _pagingController,
              builder:
                  (context, state, fetchNextPage) =>
                      PagedListView<int, PostUi>.separated(
                        state: state,
                        fetchNextPage: fetchNextPage,
                        builderDelegate: PagedChildBuilderDelegate(
                          itemBuilder:
                              (context, item, index) => PostItem(
                                key: ValueKey(item.id),
                                post: item,
                                onCommentPressed: () {
                                  Navigator.pushNamed(
                                    context,
                                    "/postDetails",
                                    arguments: {
                                      'post': item,
                                      'focusComment': true,
                                    },
                                  );
                                },
                              ),
                        ),
                        separatorBuilder: (context, index) => const Divider(),
                      ),
            ),
          ),
        ),
      ],
    );
  }
}
