import 'package:avgleclient/res/app_colors.dart';
import 'package:avgleclient/res/strings.dart';
import 'package:avgleclient/res/text_styles.dart';
import 'package:avgleclient/ui/library/library_view_model.dart';
import 'package:avgleclient/ui/library/widgets/watch_recently_carousel_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LibraryPageSignedIn extends StatelessWidget {
  const LibraryPageSignedIn({@required LibraryViewModel viewModel})
      : _viewModel = viewModel;

  final LibraryViewModel _viewModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () => _viewModel.fetchRecentlyWatchedVideos(),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
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
                  viewModel: _viewModel,
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
      ),
    );
  }
}
