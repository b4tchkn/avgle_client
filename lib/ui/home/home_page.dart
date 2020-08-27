import 'package:avgleclient/app_notifier.dart';
import 'package:avgleclient/data/model/video_res.dart';
import 'package:avgleclient/error_notifier.dart';
import 'package:avgleclient/res/app_colors.dart';
import 'package:avgleclient/res/strings.dart';
import 'package:avgleclient/ui/home/home_view_model.dart';
import 'package:avgleclient/util/converters.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';

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
                      return _videoItem(viewModel.videos[index], context);
                    }),
              )
            : const CircularProgressIndicator(),
      ),
    );
  }

  Widget _videoItem(Video video, BuildContext context) {
    final viewCount = Converters.toViewCountFormatted(video.viewnumber);
    final addedAt = Converters.toAddedAtFormatted(video.addtime);

    return InkWell(
      onTap: () => {debugPrint('video押された')},
      child: Container(
        child: Column(
          children: [
            Stack(
              children: [
                Ink.image(
                  image: NetworkImage(video.previewUrl),
                  fit: BoxFit.cover,
                  height: 220,
                ),
                Positioned(
                  bottom: 8,
                  right: 8,
                  child: Text(video.duration.toString()),
                ),
                if (video.hd)
                  Positioned(
                    top: 8,
                    right: 8,
                    child: SizedBox(
                      height: 80,
                      width: 80,
                      child: Lottie.asset('assets/lotties/video_hd_icon.json'),
                    ),
                  ),
              ],
            ),
            Container(
              padding: const EdgeInsets.only(
                top: 8,
                left: 16,
                right: 16,
                bottom: 24,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            video.title,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: const TextStyle(
                              fontSize: 14,
                              height: 1.1,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 4,
                              bottom: 4,
                            ),
                            child: Text(
                              video.keyword,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                height: 1.1,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          Text('$viewCount・$addedAt'),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                    width: 20,
                    child: IconButton(
                      padding: const EdgeInsets.all(4),
                      icon: const Icon(
                        Icons.more_vert,
                        size: 20,
                      ),
                      onPressed: () {
                        _showModalBottomSheet(context, video);
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _showModalBottomSheet(BuildContext context, Video video) {
    showModalBottomSheet<String>(
        context: context,
        builder: (BuildContext bc) {
          return Wrap(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image(
                      image: NetworkImage(video.previewUrl),
                      height: 50,
                      width: 80,
                      fit: BoxFit.cover,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            video.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const Padding(
                            padding: EdgeInsets.all(4),
                          ),
                          Text(
                            '${video.duration}',
                            maxLines: 1,
                            overflow: TextOverflow.clip,
                            style: const TextStyle(
                              color: AppColors.lightGrey,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.music_note),
                title: const Text(Strings.homeModalBottomSheetSaveWatchLater),
                onTap: () {
                  // TODO 後で見るに保存する処理
                },
              ),
              ListTile(
                leading: const Icon(Icons.ac_unit),
                title: const Text(Strings.homeModalBottomSheetSavePlayList),
                onTap: () {
                  // TODO プレイリストに保存するためのダイアログ表示
                },
              )
            ],
          );
        });
  }
}
