import 'package:avgleclient/data/model/video_res.dart';
import 'package:avgleclient/ui/library/widgets/watch_recently_item.dart';
import 'package:flutter/cupertino.dart';

class WatchRecentlyCarouselList extends StatelessWidget {
  const WatchRecentlyCarouselList({@required List<Video> recentlyWatchedVideos})
      : _recentlyWatchedVideos = recentlyWatchedVideos;

  final List<Video> _recentlyWatchedVideos;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: _recentlyWatchedVideos.length,
          itemBuilder: (BuildContext context, int index) {
            return WatchRecentlyItem(
              video: _recentlyWatchedVideos[index],
            );
          }),
    );
  }
}
