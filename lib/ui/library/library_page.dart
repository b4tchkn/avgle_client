import 'package:avgleclient/error_notifier.dart';
import 'package:avgleclient/res/app_colors.dart';
import 'package:avgleclient/res/strings.dart';
import 'package:avgleclient/res/text_styles.dart';
import 'package:avgleclient/ui/library/library_view_model.dart';
import 'package:avgleclient/ui/library/widgets/watch_recently_carousel_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';

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
      return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 16, left: 16, bottom: 8),
                child: Text(
                  Strings.libraryWatchRecently,
                  style: headerTextStyle(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
                child: WatchRecentlyCarouselList(
                  recentlyWatchedVideos: viewModel.recentlyWatchedVideos,
                ),
              ),
              const Divider(thickness: 1),
              ListTile(
                leading: const Icon(Icons.history),
                title: const Text(Strings.libraryHistory),
                onTap: () {
                  // TODO 履歴一覧に遷移
                },
              ),
              ListTile(
                leading: const Icon(Icons.access_time),
                title: const Text(Strings.libraryWatchLater),
                onTap: () {
                  // TODO 後で見る一覧に遷移
                },
              ),
              const Divider(thickness: 1),
              Padding(
                padding: const EdgeInsets.only(top: 8, left: 16, bottom: 8),
                child: Text(
                  Strings.libraryPlayList,
                  style: headerTextStyle(),
                ),
              ),
              ListTile(
                leading: const Icon(
                  Icons.add,
                  color: AppColors.accentBlue,
                ),
                title: const Text(
                  Strings.libraryNewPlayList,
                  style: TextStyle(
                    color: AppColors.accentBlue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  // TODO 履歴一覧に遷移して再生リストに追加する動画を選択できるようにする
                },
              ),
            ],
          ),
        ),
      );
    } else {
      return Scaffold(
        body: Center(
          child: !viewModel.isLoading
              ? Column(
                  children: [
                    const Text(Strings.libraryPleaseSignIn),
                    FlatButton(
                      child: const Text('sign in'),
                      onPressed: () {},
                    ),
                  ],
                )
              : const CircularProgressIndicator(),
        ),
      );
    }
  }
}
