import 'package:avgleclient/app_notifier.dart';
import 'package:avgleclient/error_notifier.dart';
import 'package:avgleclient/res/strings.dart';
import 'package:avgleclient/ui/core/video_item.dart';
import 'package:avgleclient/ui/explore/explore_view_model.dart';
import 'package:avgleclient/ui/explore/widgets/explore_categories_carousel_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ExplorePage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final error = useProvider(errorNotifierProvider);
    final viewModel = useProvider(exploreViewModelNotifierProvider);
    final fetchCategories = useMemoized(
        () => viewModel.fetchCategories(), [error.peekContent()?.type]);
    final fetchTopJAVs = useMemoized(() => viewModel.fetchTopJAVs());
    useFuture(fetchCategories);
    useFuture(fetchTopJAVs);
    final appNotifier = useProvider(appNotifierProvider);
    final scrollController = appNotifier.exploreListScrollController;
    final items = <Widget>[
      Container(
        padding: const EdgeInsets.only(left: 8, top: 8),
        child: const Text(
          Strings.exploreTopHeaderCategory,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      ExploreCategoriesCarouselList(viewModel: viewModel),
      const Divider(thickness: 2),
      Container(
        padding: const EdgeInsets.only(left: 8, bottom: 8),
        child: const Text(
          Strings.exploreTopHeaderJAV,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ];

    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
              scrollController.position.pixels &&
          viewModel.isTopJAVsHasMore) {
        viewModel.fetchTopJAVs();
      }
    });
    return Scaffold(
      body: Builder(
        builder: (BuildContext buildContext) {
          // ignore: avoid_function_literals_in_foreach_calls
          viewModel.topJAVs.forEach((video) {
            items.add(VideoItem(
              viewModel: viewModel,
              video: video,
              buildContext: buildContext,
            ));
          });
          return !viewModel.isLoading
              ? RefreshIndicator(
                  onRefresh: () => viewModel.onRefresh(),
                  child: ListView.builder(
                      controller: scrollController,
                      itemCount: items.length,
                      itemBuilder: (BuildContext _, int index) {
                        return items[index];
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
