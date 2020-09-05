import 'package:avgleclient/res/app_colors.dart';
import 'package:flutter/cupertino.dart';

class WatchRecentlyItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        width: 160,
        color: AppColors.accentBlue,
      ),
    );
  }
}
