import 'package:avgleclient/error_notifier.dart';
import 'package:avgleclient/res/app_colors.dart';
import 'package:avgleclient/ui/playlist/playlist_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PlaylistPage extends HookWidget {
  const PlaylistPage({@required String playlistName})
      : _playlistName = playlistName;

  final String _playlistName;
  @override
  Widget build(BuildContext context) {
    final error = useProvider(errorNotifierProvider);
    final viewModel = useProvider(playlistViewModelNotifierProvider);
    final fetchPlaylistVideos = useMemoized(
        () => viewModel.fetchPlaylistVideos(_playlistName),
        [error.peekContent()?.type]);
    useFuture(fetchPlaylistVideos);
    final items = <Widget>[
      Container(
        height: 200,
        color: AppColors.accentBlue,
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text(_playlistName),
      ),
      body: Builder(
        builder: (BuildContext buildContext) {
          // ignore: avoid_function_literals_in_foreach_calls
          viewModel.videos.forEach((video) {
            items.add(Text(video.title));
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
