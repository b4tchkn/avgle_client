import 'package:avgleclient/error_notifier.dart';
import 'package:avgleclient/res/app_colors.dart';
import 'package:avgleclient/res/strings.dart';
import 'package:avgleclient/ui/edit_playlist/edit_playlist_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EditPlaylistPage extends HookWidget {
  const EditPlaylistPage({@required String playlistName})
      : _playlistName = playlistName;

  final String _playlistName;
  @override
  Widget build(BuildContext context) {
    final error = useProvider(errorNotifierProvider);
    final viewModel = useProvider(editPlaylistViewModelNotifierProvider);
    final fetchPlaylistTopOneVideo = useMemoized(
        () => viewModel.fetchPlaylistTopOneVideo(_playlistName),
        [error.peekContent()?.type]);
    useFuture(fetchPlaylistTopOneVideo);

    final textEditingController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.editPlaylistAppBarTitle),
      ),
      // body: Container(
      //   child: FlatButton(
      //     child: const Text(Strings.editPlaylistUpdate),
      //     onPressed: () {
      //       viewModel.updatePlaylistName(_playlistName, '新しいプレイリ');
      //     },
      //   ),
      // ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                if (!viewModel.isLoading)
                  Image(
                    width: 120,
                    image: NetworkImage(viewModel.video.previewUrl),
                  ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(left: 24, right: 8),
                    child: TextField(
                      controller: textEditingController,
                      decoration: const InputDecoration(
                          labelText: Strings.editPlaylistTitle),
                    ),
                  ),
                ),
              ],
            ),
          ),
          FlatButton(
            child: const Text(Strings.editPlaylistUpdate),
            color: AppColors.lightGrey,
            onPressed: () {
              viewModel
                  .updatePlaylistName(_playlistName, textEditingController.text)
                  .then((value) {
                // 成功
                Navigator.pop(context);
              }).catchError((dynamic error) {
                debugPrint('updatePlaylistName $error');
              });
            },
          ),
        ],
      ),
    );
  }
}
