import 'package:avgleclient/error_notifier.dart';
import 'package:avgleclient/ui/library/library_view_model.dart';
import 'package:avgleclient/ui/library/widgets/library_page_singed_in.dart';
import 'package:avgleclient/ui/library/widgets/library_page_singned_out.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LibraryPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final error = useProvider(errorNotifierProvider);
    final viewModel = useProvider(libraryViewModelNotifierProvider);
    final fetchRecentlyWatchedVideos = useMemoized(
        () => viewModel.fetchRecentlyWatchedVideos(),
        [error.peekContent()?.type]);
    final fetchUser =
        useMemoized(() => viewModel.fetchUser(), [error.peekContent()?.type]);
    useFuture(fetchUser);
    useFuture(fetchRecentlyWatchedVideos);
    if (viewModel.user != null && !viewModel.isLoading) {
      return LibraryPageSignedIn(viewModel: viewModel);
    } else {
      return LibraryPageSignedOut(viewModel: viewModel);
    }
  }
}
