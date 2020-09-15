import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

final appNotifierProvider =
    ChangeNotifierProvider((ref) => AppNotifierProvider(ref));

class AppNotifierProvider extends ChangeNotifier {
  AppNotifierProvider(ProviderReference ref);
  int currentIndex = 0;
  ScrollController homeListScrollController = ScrollController();
  ScrollController exploreListScrollController = ScrollController();

  Future<Database> database;

  void onTapped(int index) {
    if (currentIndex == index && index == 0) {
      homeListScrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
      notifyListeners();
    }
    if (currentIndex == index && index == 1) {
      exploreListScrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
      notifyListeners();
    }
    currentIndex = index;
    notifyListeners();
  }

  Future<void> init() async {
    database = openDatabase(
      join(await getDatabasesPath(), 'history.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE history(id INTEGER PRIMARY KEY AUTOINCREMENT, keyword TEXT)',
        );
      },
      version: 1,
    );
  }
}
