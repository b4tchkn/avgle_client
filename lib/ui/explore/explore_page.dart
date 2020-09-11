import 'package:avgleclient/error_notifier.dart';
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
    final fetchExploreTopJAVs =
        useMemoized(() => viewModel.fetchExploreTopJAVs());
    useFuture(fetchCategories);
    useFuture(fetchExploreTopJAVs);
    final items = <Widget>[
      ExploreCategoriesCarouselList(viewModel: viewModel),
      const Divider(thickness: 2),
    ];
    return Scaffold(
      body: Builder(
        builder: (BuildContext buildContext) {
          // ignore: avoid_function_literals_in_foreach_calls
          viewModel.topJAVs.forEach((video) {
            items.add(Container(
              child: Text(video.title),
            ));
          });
          return !viewModel.isLoading
              ? RefreshIndicator(
                  onRefresh: () => viewModel.onRefresh(),
                  child: ListView.builder(
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
      floatingActionButton: FloatingActionButton(
        onPressed: () => viewModel.increment(),
      ),
    );
  }
}
