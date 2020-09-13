import 'package:avgleclient/data/model/video_res.dart';
import 'package:avgleclient/res/app_colors.dart';
import 'package:avgleclient/res/strings.dart';
import 'package:avgleclient/ui/core/playlist_dialog.dart';
import 'package:avgleclient/ui/watch_later/watch_later_view_model.dart';
import 'package:avgleclient/util/converters.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WatchLaterVideoMoreModalBottomSheet extends StatelessWidget {
  const WatchLaterVideoMoreModalBottomSheet(
      {@required WatchLaterViewModel viewModel,
      @required Video video,
      @required List<String> playlists,
      @required BuildContext buildContext})
      : _viewModel = viewModel,
        _video = video,
        _playlists = playlists,
        _buildContext = buildContext;

  final WatchLaterViewModel _viewModel;
  final Video _video;
  final List<String> _playlists;
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
                      Converters.toVideoDurationFormatted(_video.duration),
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
          title: const Text(Strings.watchLaterModalBottomSheetDelete),
          onTap: () {
            // TODO 後で見るから削除するための処理
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: const Icon(Icons.video_library),
          title: const Text(Strings.watchLaterModalBottomSheetSavePlayList),
          onTap: () {
            Navigator.pop(context);
            showDialog(
                context: context,
                builder: (BuildContext dialogContext) {
                  return PlaylistDialog(
                    viewModel: _viewModel,
                    video: _video,
                    playlists: _playlists,
                    buildContext: _buildContext,
                    dialogContext: dialogContext,
                  );
                });
          },
        )
      ],
    );
  }
}
