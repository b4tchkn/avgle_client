import 'package:avgleclient/res/strings.dart';
import 'package:avgleclient/ui/core/snack_bar.dart';
import 'package:avgleclient/ui/library/library_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LibraryCreatePlaylistDialog extends StatelessWidget {
  const LibraryCreatePlaylistDialog(
      {@required LibraryViewModel viewModel,
      @required BuildContext dialogContext,
      @required BuildContext buildContext})
      : _viewModel = viewModel,
        _dialogContext = dialogContext,
        _buildContext = buildContext;

  final LibraryViewModel _viewModel;
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
            _viewModel.createPlaylistOnly(textController.text).then((value) {
              showSimpleSnackBar(
                  _buildContext, Strings.libraryCreatePlaylistSuccess);
            });
          },
        ),
      ],
    );
  }
}
