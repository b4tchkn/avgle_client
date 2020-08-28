import 'package:avgleclient/app_notifier.dart';
import 'package:avgleclient/error_notifier.dart';
import 'package:avgleclient/ui/home/home_view_model.dart';
import 'package:avgleclient/ui/home/widgets/video_item.dart';
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
    final appNotifier = useProvider(appNotifierProvider);
    final scrollController = appNotifier.homeListScrollController;
    if (!error.hasBeenHandled) {}

    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.position.pixels) {
        viewModel.getVideos();
      }
    });
    return Scaffold(
      body: Center(
        child: !viewModel.isLoading
            ? RefreshIndicator(
                onRefresh: () => viewModel.refreshAndGetVideos(),
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: viewModel.videos.length,
                  itemBuilder: (BuildContext context, int index) {
                    return VideoItem(
                        video: viewModel.videos[index], context: context);
                  },
                ),
              )
            : const CircularProgressIndicator(),
      ),
    );
  }
}
