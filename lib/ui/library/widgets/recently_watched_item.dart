import 'package:avgleclient/data/model/video_res.dart';
import 'package:flutter/cupertino.dart';

class RecentlyWatchedItem extends StatelessWidget {
  const RecentlyWatchedItem({@required Video video}) : _video = video;

  final Video _video;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        width: 160,
        child: Column(
          children: [
            Text(_video.title),
          ],
        ),
      ),
    );
  }
}
