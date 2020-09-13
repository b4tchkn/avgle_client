import 'package:avgleclient/error_notifier.dart';
import 'package:avgleclient/res/strings.dart';
import 'package:avgleclient/ui/watch_later/watch_later_view_model.dart';
import 'package:avgleclient/ui/watch_later/widgets/watch_later_top_item.dart';
import 'package:avgleclient/ui/watch_later/widgets/watch_later_vieo_list_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class WatchLaterPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final error = useProvider(errorNotifierProvider);
    final viewModel = useProvider(watchLaterViewModelNotifierProvider);
    final fetchWatchLaterVideos = useMemoized(
        () => viewModel.fetchWatchLaterVideos(), [error.peekContent()?.type]);
    final fetchPlaylists = useMemoized(
        () => viewModel.fetchPlaylists(), [error.peekContent()?.type]);
    useFuture(fetchWatchLaterVideos);
    useFuture(fetchPlaylists);
    final items = <Widget>[WatchLaterTopItem()];
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.watchLaterAppBarTitle),
      ),
      body: Builder(
        builder: (BuildContext buildContext) {
          // ignore: avoid_function_literals_in_foreach_calls
          viewModel.videos.forEach((video) {
            items.add(WatchLaterVideoListTile(
              viewModel: viewModel,
              video: video,
              playlists: viewModel.playlists,
              buildContext: buildContext,
            ));
          });
          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return items[index];
            },
          );
        },
      ),
    );
  }
}
