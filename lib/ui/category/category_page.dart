import 'package:avgleclient/data/model/category_res.dart';
import 'package:avgleclient/error_notifier.dart';
import 'package:avgleclient/ui/category/category_view_model.dart';
import 'package:avgleclient/ui/category/widgets/category_top_item.dart';
import 'package:avgleclient/ui/category/widgets/category_video_list_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CategoryPage extends HookWidget {
  const CategoryPage({@required Category category}) : _category = category;

  final Category _category;
  @override
  Widget build(BuildContext context) {
    final error = useProvider(errorNotifierProvider);
    final viewModel = useProvider(categoryViewModelNotifierProvider);
    final fetchCategoryVideos = useMemoized(
        () => viewModel.onRefresh(_category.slug), [error.peekContent()?.type]);
    useFuture(fetchCategoryVideos);
    final scrollController = ScrollController();
    final items = <Widget>[
      CategoryTopItem(
        category: _category,
        videoCount: viewModel.totalVideoCount,
      ),
    ];
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
              scrollController.position.pixels &&
          viewModel.isCategoryVideosHasMore) {
        viewModel.fetchCategoryVideos(_category.slug);
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: Text(_category.name),
      ),
      body: Builder(
        builder: (BuildContext buildContext) {
          if (viewModel.isLoading) {
            items.add(
              const Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            viewModel.categoryVideos.forEach((video) {
              items.add(CategoryVideoListTile(
                viewModel: viewModel,
                video: video,
                buildContext: buildContext,
              ));
            });
          }
          return RefreshIndicator(
            onRefresh: () => viewModel.onRefresh(_category.slug),
            child: ListView.builder(
                controller: scrollController,
                itemCount: items.length,
                itemBuilder: (BuildContext _, int index) {
                  return items[index];
                }),
          );
        },
      ),
    );
  }
}
