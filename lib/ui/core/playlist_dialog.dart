import 'package:avgleclient/data/model/video_res.dart';
import 'package:avgleclient/res/strings.dart';
import 'package:avgleclient/ui/core/snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlaylistDialog extends StatelessWidget {
  const PlaylistDialog(
      {@required dynamic viewModel,
      @required Video video,
      @required List<String> playlists,
      @required BuildContext buildContext,
      @required BuildContext dialogContext})
      : _viewModel = viewModel,
        _video = video,
        _playlists = playlists,
        _buildContext = buildContext,
        _dialogContext = dialogContext;

  final dynamic _viewModel;
  final Video _video;
  final List<String> _playlists;
  final BuildContext _buildContext;
  final BuildContext _dialogContext;

  @override
  Widget build(BuildContext context) {
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
      dialogContents.add(ListTile(
        title: Text(playlist),
        onTap: () {
          Navigator.pop(_dialogContext);
          _viewModel.addVideoInPlaylist(playlist, _video).then((value) {
            showSimpleSnackBar(_buildContext, Strings.coreSavePlaylistSuccess);
          }).catchError((error) {
            debugPrint(error.toString());
            showSimpleSnackBar(_buildContext, Strings.coreSavePlaylistFailure);
          });
        },
      ));
    });
    dialogContents.add(const Divider());
    dialogContents.add(ListTile(
      leading: const Icon(Icons.add),
      title: const Text(Strings.corePlayListDialogNewPlayList),
      onTap: () {
        Navigator.pop(_dialogContext);
        // TODO 新しいプレイリストを作るダイアログ表示
      },
    ));

    return Dialog(
      child: Wrap(
        children: dialogContents,
      ),
    );
  }
}
