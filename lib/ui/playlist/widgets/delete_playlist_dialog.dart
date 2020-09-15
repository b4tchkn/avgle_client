import 'package:avgleclient/res/strings.dart';
import 'package:avgleclient/ui/core/snack_bar.dart';
import 'package:avgleclient/ui/playlist/playlist_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DeletePlaylistDialog extends StatelessWidget {
  const DeletePlaylistDialog(
      {@required PlaylistViewModel viewModel,
      @required String playlistName,
      @required BuildContext dialogContext,
      @required BuildContext buildContext})
      : _viewModel = viewModel,
        _playlistName = playlistName,
        _dialogContext = dialogContext,
        _buildContext = buildContext;

  final PlaylistViewModel _viewModel;
  final String _playlistName;
  final BuildContext _dialogContext;
  final BuildContext _buildContext;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(Strings.playlistDeletePlaylistDialogTitle),
      actions: [
        FlatButton(
          child: const Text(Strings.playlistDeletePlaylistDialogCancel),
          onPressed: () {
            Navigator.pop(_dialogContext);
          },
        ),
        FlatButton(
          child: const Text(Strings.playlistDeletePlaylistDialogDelete),
          onPressed: () {
            Navigator.pop(_dialogContext);
            _viewModel.deletePlaylist(_playlistName).then((value) {
              showSimpleSnackBar(
                  _buildContext, Strings.playlistDeletePlaylistSuccess);
            }).catchError((_) {
              showSimpleSnackBar(
                  _buildContext, Strings.playlistDeletePlaylistFailure);
            });
          },
        ),
      ],
    );
  }
}
