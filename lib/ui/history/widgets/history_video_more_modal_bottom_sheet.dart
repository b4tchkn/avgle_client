import 'package:avgleclient/data/model/video_res.dart';
import 'package:avgleclient/res/app_colors.dart';
import 'package:avgleclient/res/strings.dart';
import 'package:avgleclient/ui/core/snack_bar.dart';
import 'package:avgleclient/ui/history/history_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HistoryVideoMoreModalBottomSheet extends StatelessWidget {
  const HistoryVideoMoreModalBottomSheet(
      {@required HistoryViewModel viewModel,
      @required Video video,
      @required BuildContext buildContext})
      : _viewModel = viewModel,
        _video = video,
        _buildContext = buildContext;

  final HistoryViewModel _viewModel;
  final Video _video;
  final BuildContext _buildContext;
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
                image: NetworkImage(_video.previewUrl),
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
                      _video.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(4),
                    ),
                    Text(
                      '${_video.duration}',
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
          leading: const Icon(Icons.delete),
          title: const Text(Strings.historyModalBottomSheetDelete),
          onTap: () {
            Navigator.pop(context);
            // TODO 再生履歴から削除するための処理
          },
        ),
        ListTile(
          leading: const Icon(Icons.watch_later),
          title: const Text(Strings.historyModalBottomSheetSaveWatchLater),
          onTap: () {
            Navigator.pop(context);
            _viewModel.addVideoInWatchLater(_video).then((value) {
              showSimpleSnackBar(
                  _buildContext, Strings.historySaveWatchLaterSuccess);
            }).catchError((error) {
              debugPrint(error.toString());
              showSimpleSnackBar(_buildContext, Strings.historySaveFailure);
            });
          },
        ),
        ListTile(
          leading: const Icon(Icons.video_library),
          title: const Text(Strings.historyModalBottomSheetSavePlayList),
          onTap: () {
            Navigator.pop(context);
            // TODO プレイリストに保存するためのダイアログ表示
          },
        )
      ],
    );
  }
}
