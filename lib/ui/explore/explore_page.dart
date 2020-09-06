import 'package:avgleclient/error_notifier.dart';
import 'package:avgleclient/ui/explore/explore_view_model.dart';
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
              ? Center(
                  child: Column(
                    children: [
                      Text(viewModel.categories[0].shortname),
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
