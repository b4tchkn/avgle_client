import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final exploreViewModelNotifierProvider =
    ChangeNotifierProvider((ref) => ExploreViewModel(ref));

class ExploreViewModel extends ChangeNotifier {
  ExploreViewModel(ProviderReference ref);

  var _count = 0;
  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();
  }
}
