import 'package:avgleclient/res/strings.dart';
import 'package:avgleclient/ui/edit_playlist/edit_playlist_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EditPlaylistPage extends HookWidget {
  EditPlaylistPage({@required String playlistName})
      : _playlistName = playlistName;

  final String _playlistName;
  @override
  Widget build(BuildContext context) {
    final viewModel = useProvider(editPlaylistViewModelNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.editPlaylistAppBarTitle),
      ),
      body: Container(
        child: FlatButton(
          child: Text('更新'),
          onPressed: () {
            viewModel.updatePlaylistName(_playlistName, '新しいプレイリ');
          },
        ),
      ),
    );
  }
}
