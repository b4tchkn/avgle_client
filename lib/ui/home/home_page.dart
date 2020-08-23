import 'package:avgleclient/data/model/video_res.dart';
import 'package:avgleclient/error_notifier.dart';
import 'package:avgleclient/ui/home/home_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomePage extends HookWidget {
  var _videos = <Video>[];
  @override
  Widget build(BuildContext context) {
    var _videoPage = 0;
    final error = useProvider(errorNotifierProvider);
    final viewModel = useProvider(homeViewModelNotifierProvider);
    final getVideos = useMemoized(
        () => viewModel.getVideos(_videoPage.toString()),
        [error.peekContent()?.type]);
    final snapshot = useFuture(getVideos);
    if (!error.hasBeenHandled) {}

    if (snapshot.hasData) {
      _videos = snapshot.data.response.videos;
    }
    final _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.position.pixels) {
        if (!viewModel.isLoading) {
          debugPrint('きったああ ${viewModel.isLoading}');
          debugPrint(_videos.length.toString());
          _videoPage++;
          getVideosMore(_videoPage.toString());
          debugPrint(_videos.length.toString());
        }
      }
    });
    return Scaffold(
      body: Center(
        child: snapshot.hasData
            ? ListView.builder(
                controller: _scrollController,
                itemCount: _videos.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: Image(
                      image: NetworkImage(_videos[index].previewUrl),
                    ),
                  );
                })
            : const CircularProgressIndicator(),
      ),
    );
  }

  void getVideosMore(String page) {
    debugPrint('getVideosMore');
//    final error = useProvider(errorNotifierProvider);
//    final viewModel = useProvider(homeViewModelNotifierProvider);
//    viewModel.videoRes.toString();
//    final getVideos = useMemoized(
//        () => viewModel.getVideos(page), [error.peekContent()?.type]);
//    final snapshot = useFuture(getVideos);
//    if (snapshot.hasData) {
//      _videos.addAll(snapshot.data.response.videos);
//    }
  }
}
