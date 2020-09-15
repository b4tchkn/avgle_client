import 'package:avgleclient/data/model/history.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

final searchViewModelNotifierProvider =
    ChangeNotifierProvider((ref) => SearchViewModel());

class SearchViewModel extends ChangeNotifier {
  Future<Database> database;

  List<History> _histories = [];
  List<History> get histories => _histories;

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

  Future<void> addSearchHistory(String searchWord) async {
    final history = History(id: searchWord.hashCode, keyword: searchWord);
    final db = await database;
    await db.insert('history', history.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> getSearchHistories() async {
    final db = await database;
    final maps = await db.query('history');
    _histories = List.generate(maps.length, (index) {
      return History(
          id: int.parse(maps[index]['id'].toString()),
          keyword: maps[index]['keyword'].toString());
    });
    notifyListeners();
  }
}
