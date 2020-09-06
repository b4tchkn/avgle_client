import 'package:avgleclient/error_notifier.dart';
import 'package:avgleclient/res/strings.dart';
import 'package:avgleclient/ui/history/history_view_model.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.historyAppBarTitle),
      ),
      body: Builder(
        builder: (BuildContext buildContext) {
          return !viewModel.isLoading
              ? ListView.builder(
                  itemCount: viewModel.videos.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      child: Text(viewModel.videos[index].title),
                    );
                  })
              : const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
