import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final appNotifierProvider =
    ChangeNotifierProvider((ref) => AppNotifierProvider(ref));

class AppNotifierProvider extends ChangeNotifier {
  AppNotifierProvider(ProviderReference ref);
  int currentIndex = 0;

  void onTapped(int index) {
    currentIndex = index;
    notifyListeners();
    debugPrint(currentIndex.toString());
  }
}
