import 'package:avgleclient/error_notifier.dart';
import 'package:avgleclient/ui/home/home_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomePage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final error = useProvider(errorNotifierProvider);
    final viewModel = useProvider(homeViewModelNotifierProvider);
    final getVideos =
        useMemoized(() => viewModel.getVideos(), [error.peekContent()?.type]);
    useFuture(getVideos);
    if (!error.hasBeenHandled) {}

    final _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.position.pixels) {
        viewModel.getVideos();
      }
    });
    return Scaffold(
      body: Center(
        child: !viewModel.isLoading
            ? ListView.builder(
                controller: _scrollController,
                itemCount: viewModel.videos.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: Image(
                      image: NetworkImage(viewModel.videos[index].previewUrl),
                    ),
                  );
                })
            : const CircularProgressIndicator(),
      ),
    );
  }
}
