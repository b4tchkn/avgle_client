import 'package:avgleclient/error_notifier.dart';
import 'package:avgleclient/ui/home/home_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomePage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final error = useProvider(errorNotifierProvider);
    final viewModel = useProvider(homeViewModelNotifierProvider);
    final getVideos =
        useMemoized(() => viewModel.getVideos(), [error.peekContent()?.type]);
    final snapshot = useFuture(getVideos);

    if (!error.hasBeenHandled) {}

    return Scaffold(
      body: Center(
        child: snapshot.hasData
            ? Text(snapshot.data.response.videos[3].title)
            : CircularProgressIndicator(),
      ),
    );
  }
}
