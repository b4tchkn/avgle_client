import 'package:avgleclient/app_notifier.dart';
import 'package:avgleclient/error_notifier.dart';
import 'package:avgleclient/ui/home/home_view_model.dart';
import 'package:avgleclient/ui/core/video_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomePage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final error = useProvider(errorNotifierProvider);
    final viewModel = useProvider(homeViewModelNotifierProvider);
    final fetchVideos =
        useMemoized(() => viewModel.fetchVideos(), [error.peekContent()?.type]);
    useFuture(fetchVideos);
    final fetchPlaylists = useMemoized(
        () => viewModel.fetchPlaylists(), [error.peekContent()?.type]);
    useFuture(fetchPlaylists);
    final appNotifier = useProvider(appNotifierProvider);
    final scrollController = appNotifier.homeListScrollController;
    if (!error.hasBeenHandled) {}

    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
              scrollController.position.pixels &&
          viewModel.videoRes.response.hasMore) {
        viewModel.fetchVideos();
      }
    });
    return Scaffold(
      body: Builder(
        builder: (BuildContext buildContext) {
          return Center(
            child: !viewModel.isLoading
                ? RefreshIndicator(
                    onRefresh: () => viewModel.refreshAndGetVideos(),
                    child: ListView.builder(
                        controller: scrollController,
                        itemCount: viewModel.videos.length,
                        itemBuilder: (BuildContext context, int index) {
                          return VideoItem(
                            viewModel: viewModel,
                            video: viewModel.videos[index],
                            playlists: viewModel.playLists,
                            buildContext: buildContext,
                          );
                        }),
                  )
                : const CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
