import 'package:avgleclient/data/model/video_res.dart';
import 'package:avgleclient/res/app_colors.dart';
import 'package:avgleclient/res/strings.dart';
import 'package:avgleclient/ui/home/home_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VideoMoreModalBottomSheet extends StatelessWidget {
  const VideoMoreModalBottomSheet(
      {@required this.viewModel, @required this.video});

  final Video video;
  final HomeViewModel viewModel;
  @override
  Widget build(BuildContext context) {
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
          leading: const Icon(Icons.access_time),
          title: const Text(Strings.homeModalBottomSheetSaveWatchLater),
          onTap: () {
            // TODO 後で見るに保存する処理
            debugPrint('VideoMoreModalBottomSheetの中| ${video.title}');
            viewModel.addVideoInWatchLater(video);
//            viewModel.addVideoInWatchLater(video).then((value) {
//              debugPrint('VideoMoreModalBottomSheetの中|成功');
//            }).catchError((String err) {
//              debugPrint('VideoMoreModalBottomSheetの中|失敗');
//            });
          },
        ),
        ListTile(
          leading: const Icon(Icons.video_library),
          title: const Text(Strings.homeModalBottomSheetSavePlayList),
          onTap: () {
            // TODO プレイリストに保存するためのダイアログ表示
          },
        )
      ],
    );
  }
}
