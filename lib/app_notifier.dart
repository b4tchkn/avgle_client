import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final appNotifierProvider =
    ChangeNotifierProvider((ref) => AppNotifierProvider(ref));

class AppNotifierProvider extends ChangeNotifier {
  AppNotifierProvider(ProviderReference ref);
  int currentIndex = 0;
  ScrollController homeListScrollController = ScrollController();

  void onTapped(int index) {
    if (currentIndex == index && index == 0) {
      homeListScrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
      notifyListeners();
    }
    currentIndex = index;
    notifyListeners();
  }
}
