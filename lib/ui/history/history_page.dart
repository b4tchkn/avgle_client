import 'package:avgleclient/error_notifier.dart';
import 'package:avgleclient/res/strings.dart';
import 'package:avgleclient/ui/history/history_view_model.dart';
import 'package:avgleclient/ui/history/widgets/history_search_bar.dart';
import 'package:avgleclient/ui/history/widgets/history_video_list_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HistoryPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final error = useProvider(errorNotifierProvider);
    final viewModel = useProvider(historyViewModelNotifierProvider);
    final fetchHistoryVideos = useMemoized(
        () => viewModel.fetchHistoryVideos(), [error.peekContent()?.type]);
    useFuture(fetchHistoryVideos);
    final items = <Widget>[
      HistorySearchBar(
        viewModel: viewModel,
      )
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.historyAppBarTitle),
      ),
      body: Builder(
        builder: (BuildContext buildContext) {
          // ignore: avoid_function_literals_in_foreach_calls
          viewModel.videos.forEach((video) {
            items.add(HistoryVideoListTile(
              viewModel: viewModel,
              video: video,
              buildContext: buildContext,
            ));
          });
          return !viewModel.isLoading
              ? RefreshIndicator(
                  onRefresh: () => viewModel.refresh(),
                  child: ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (BuildContext context, int index) {
                        return items[index];
                      }),
                )
              : const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
