import 'package:avgleclient/res/app_colors.dart';
import 'package:avgleclient/ui/library/widgets/watch_recently_item.dart';
import 'package:flutter/cupertino.dart';

class WatchRecentlyCarouselList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) {
            return WatchRecentlyItem();
          }),
    );
  }
}
