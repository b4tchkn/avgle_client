import 'package:avgleclient/ui/core/shimmer_container.dart';
import 'package:flutter/cupertino.dart';

class RecentlyWatchedPlaceHolderItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        width: 160,
        child: Column(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 4),
              child: ShimmerContainer(
                width: 160,
                height: 80,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 4, right: 16),
              child: ShimmerContainer(
                width: 160,
                height: 20,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(right: 28),
              child: ShimmerContainer(
                width: 160,
                height: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
