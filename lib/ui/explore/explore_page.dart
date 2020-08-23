import 'package:avgleclient/ui/explore/explore_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ExplorePage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = useProvider(exploreViewModelNotifierProvider);

    return Scaffold(
      body: Center(
        child: Text(viewModel.count.toString()),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => viewModel.increment(),
      ),
    );
  }
}
