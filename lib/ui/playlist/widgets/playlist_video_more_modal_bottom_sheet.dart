import 'package:avgleclient/data/model/video_res.dart';
import 'package:avgleclient/res/app_colors.dart';
import 'package:avgleclient/res/strings.dart';
import 'package:avgleclient/ui/core/snack_bar.dart';
import 'package:avgleclient/ui/playlist/playlist_view_model.dart';
import 'package:avgleclient/util/converters.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlaylistVideoMoreModalBottomSheet extends StatelessWidget {
  const PlaylistVideoMoreModalBottomSheet(
      {@required PlaylistViewModel viewModel,
      @required Video video,
      @required String playlistName,
      @required BuildContext buildContext})
      : _viewModel = viewModel,
        _video = video,
        _playlistName = playlistName,
        _buildContext = buildContext;

  final PlaylistViewModel _viewModel;
  final Video _video;
  final String _playlistName;
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
          title: Text(
              Strings.playlistModalBottomSheetDeletePlaylist(_playlistName)),
          onTap: () {
            Navigator.pop(context);
            _viewModel
                .deleteVideoInPlaylist(_video.vid, _playlistName)
                .then((value) {
              showSimpleSnackBar(
                  _buildContext, Strings.playlistDeleteVideoInPlaylistSuccess);
            }).catchError((dynamic error) {
              showSimpleSnackBar(
                  _buildContext, Strings.playlistDeleteVideoInPlaylistFailure);
            });
          },
        ),
        ListTile(
          leading: const Icon(Icons.watch_later),
          title: const Text(Strings.playlistModalBottomSheetSaveWatchLater),
          onTap: () {
            Navigator.pop(context);
            _viewModel.addVideoInWatchLater(_video).then((value) {
              showSimpleSnackBar(
                  _buildContext, Strings.playlistSaveWatchLaterSuccess);
            }).catchError((_) {
              showSimpleSnackBar(
                  _buildContext, Strings.playlistSaveWatchLaterFailure);
            });
          },
        )
      ],
    );
  }
}
