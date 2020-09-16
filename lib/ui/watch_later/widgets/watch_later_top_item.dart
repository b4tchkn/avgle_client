import 'package:avgleclient/data/provider/firebase_auth_provider.dart';
import 'package:avgleclient/res/app_colors.dart';
import 'package:avgleclient/res/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';

class WatchLaterTopItem extends HookWidget {
  const WatchLaterTopItem({@required int videoCount})
      : _videoCount = videoCount;

  final int _videoCount;
  @override
  Widget build(BuildContext context) {
    final user = useProvider(firebaseAuthProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 160,
          width: MediaQuery.of(context).size.width,
          color: AppColors.darkGrey,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  Strings.watchLaterYourWatchLater(
                      user.currentUser.displayName),
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                    height: 120,
                    child: Image.asset('assets/images/icon_kachinko.png')),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 16, top: 8, bottom: 8),
          child: Text(
            Strings.watchLaterTopItemVideoCount(_videoCount),
            style: const TextStyle(fontSize: 14),
          ),
        ),
      ],
    );
  }
}
