import 'package:avgleclient/data/model/video_res.dart';
import 'package:avgleclient/res/app_colors.dart';
import 'package:avgleclient/res/strings.dart';
import 'package:avgleclient/ui/core/snack_bar.dart';
import 'package:avgleclient/util/converters.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VideoMoreModalBottomSheet extends StatelessWidget {
  const VideoMoreModalBottomSheet(
      {@required dynamic viewModel,
      @required Video video,
      @required List<String> playlists,
      @required BuildContext buildContext})
      : _viewModel = viewModel,
        _video = video,
        _playlists = playlists,
        _buildContext = buildContext;

  final dynamic _viewModel;
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
          leading: const Icon(Icons.access_time),
          title: const Text(Strings.homeModalBottomSheetSaveWatchLater),
          onTap: () {
            Navigator.pop(context);
            _viewModel.addVideoInWatchLater(_video).then((value) {
              // onSuccess
              showSimpleSnackBar(
                  _buildContext, Strings.homeSaveWatchLaterSuccess);
            }).catchError((error) {
              // onFailure
              debugPrint(error.toString());
              showSimpleSnackBar(
                  _buildContext, Strings.homeSaveWatchLaterFailure);
            });
          },
        ),
        ListTile(
          leading: const Icon(Icons.video_library),
          title: const Text(Strings.homeModalBottomSheetSavePlayList),
          onTap: () {
            Navigator.pop(context);
            final dialogContents = <Widget>[
              Container(
                child: const Text(
                  Strings.corePlayListDialogTitle,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                padding: const EdgeInsets.all(16),
              ),
              const Divider(),
            ];
            // ignore: avoid_function_literals_in_foreach_calls
            _playlists.forEach((playlist) {
              dialogContents.add(
                ListTile(
                  title: Text(playlist),
                  onTap: () {
                    _viewModel.addVideoInPlaylist(playlist, _video);
                  },
                ),
              );
            });
            dialogContents.add(const Divider());
            dialogContents.add(ListTile(
              leading: const Icon(Icons.add),
              title: const Text(Strings.corePlayListDialogNewPlayList),
              onTap: () {
                // TODO 新しいプレイリストを作るダイアログ表示
              },
            ));
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return Dialog(
                  child: Wrap(
                    children: dialogContents,
                  ),
                );
              },
            );
          },
        )
      ],
    );
  }
}
