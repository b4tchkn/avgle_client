import 'package:avgleclient/ui/library/library_view_model.dart';
import 'package:avgleclient/ui/library/widgets/recently_watched_place_holder_item.dart';
import 'package:avgleclient/ui/library/widgets/recently_watched_item.dart';
import 'package:flutter/cupertino.dart';

class WatchRecentlyCarouselList extends StatelessWidget {
  const WatchRecentlyCarouselList({@required LibraryViewModel viewModel})
      : _viewModel = viewModel;

  final LibraryViewModel _viewModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: _viewModel.isLoadingRecentlyWatchedLaterVideo
              ? 10
              : _viewModel.recentlyWatchedVideos.length,
          itemBuilder: (BuildContext context, int index) {
            return _viewModel.isLoadingRecentlyWatchedLaterVideo
                ? RecentlyWatchedPlaceHolderItem()
                : RecentlyWatchedItem(
                    video: _viewModel.recentlyWatchedVideos[index],
                  );
          }),
    );
  }
}
