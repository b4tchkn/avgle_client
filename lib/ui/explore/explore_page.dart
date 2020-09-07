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
    useFuture(fetchCategories);
    return Scaffold(
      body: Builder(
        builder: (BuildContext buildContext) {
          return !viewModel.isLoading
              ? SingleChildScrollView(
                  child: Column(
                    children: [
                      ExploreCategoriesCarouselList(
                        viewModel: viewModel,
                      ),
                      const Divider(thickness: 2),
                      Text(viewModel.count.toString()),
                    ],
                  ),
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
