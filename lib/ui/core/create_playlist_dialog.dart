import 'package:avgleclient/data/model/video_res.dart';
import 'package:avgleclient/res/strings.dart';
import 'package:avgleclient/ui/core/snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreatePlaylistDialog extends StatelessWidget {
  const CreatePlaylistDialog(
      {@required dynamic viewModel,
      @required Video video,
      @required BuildContext dialogContext,
      @required BuildContext buildContext})
      : _viewModel = viewModel,
        _video = video,
        _dialogContext = dialogContext,
        _buildContext = buildContext;

  final dynamic _viewModel;
  final Video _video;
  final BuildContext _dialogContext;
  final BuildContext _buildContext;
  @override
  Widget build(BuildContext context) {
    final textController = TextEditingController();
    return AlertDialog(
      title: const Text(Strings.coreCreateNewPlaylistDialogTitle),
      content: TextField(
        maxLength: 15,
        maxLengthEnforced: false,
        controller: textController,
        decoration: const InputDecoration(
            labelText: Strings.coreCreateNewPlaylistDialogPlaylistTitle),
      ),
      actions: [
        FlatButton(
          child: const Text(Strings.coreCreateNewPlaylistDialogCancel),
          onPressed: () {
            Navigator.pop(_dialogContext);
          },
        ),
        FlatButton(
          child: const Text(Strings.coreCreateNewPlaylistDialogCreate),
          onPressed: () {
            Navigator.pop(_dialogContext);
            _viewModel
                .createPlaylist(textController.text, _video)
                .then((value) {
              showSimpleSnackBar(
                  _buildContext, Strings.coreSavePlaylistSuccess);
            });
          },
        ),
      ],
    );
  }
}
