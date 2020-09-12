import 'package:avgleclient/error_notifier.dart';
import 'package:avgleclient/ui/category/category_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CategoryPage extends HookWidget {
  const CategoryPage({@required String categoryName, @required String slug})
      : _categoryName = categoryName,
        _slug = slug;

  final String _categoryName;
  final String _slug;
  @override
  Widget build(BuildContext context) {
    final error = useProvider(errorNotifierProvider);
    final viewModel = useProvider(categoryViewModelNotifierProvider);
    final fetchCategoryVideos = useMemoized(
        () => viewModel.onRefresh(_slug), [error.peekContent()?.type]);
    useFuture(fetchCategoryVideos);
    final scrollController = ScrollController();
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
              scrollController.position.pixels &&
          viewModel.isCategoryVideosHasMore) {
        viewModel.fetchCategoryVideos(_slug);
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: Text(_categoryName),
      ),
      body: Builder(
        builder: (BuildContext buildContext) {
          return !viewModel.isLoading
              ? RefreshIndicator(
                  onRefresh: () => viewModel.onRefresh(_slug),
                  child: ListView.builder(
                      controller: scrollController,
                      itemCount: viewModel.categoryVideos.length,
                      itemBuilder: (BuildContext _, int index) {
                        return Text(viewModel.categoryVideos[index].title);
                      }),
                )
              : const Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}
