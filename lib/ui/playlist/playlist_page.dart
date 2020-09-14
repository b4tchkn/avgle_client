import 'package:avgleclient/error_notifier.dart';
import 'package:avgleclient/ui/playlist/playlist_view_model.dart';
import 'package:avgleclient/ui/playlist/widgets/playlist_top_item.dart';
import 'package:avgleclient/ui/playlist/widgets/playlist_video_list_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PlaylistPage extends HookWidget {
  const PlaylistPage({@required String playlistName, @required String userName})
      : _playlistName = playlistName,
        _userName = userName;

  final String _playlistName;
  final String _userName;
  @override
  Widget build(BuildContext context) {
    final error = useProvider(errorNotifierProvider);
    final viewModel = useProvider(playlistViewModelNotifierProvider);
    final fetchPlaylistVideos = useMemoized(
        () => viewModel.fetchPlaylistVideos(_playlistName),
        [error.peekContent()?.type]);
    useFuture(fetchPlaylistVideos);
    final items = <Widget>[
      PlaylistTopItem(
        playlistName: _playlistName,
        userName: _userName,
        videoCount: viewModel.videos.length,
      )
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text(_playlistName),
      ),
      body: Builder(
        builder: (BuildContext buildContext) {
          // ignore: avoid_function_literals_in_foreach_calls
          viewModel.videos.forEach((video) {
            items.add(PlaylistVideoListTile(
              viewModel: viewModel,
              video: video,
              playlistName: _playlistName,
              buildContext: buildContext,
            ));
          });

          return RefreshIndicator(
            onRefresh: () => viewModel.fetchPlaylistVideos(_playlistName),
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (_, index) {
                return items[index];
              },
            ),
          );
        },
      ),
    );
  }
}
