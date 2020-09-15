import 'package:avgleclient/data/model/history.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sqflite/sqflite.dart';

final searchViewModelNotifierProvider =
    ChangeNotifierProvider((ref) => SearchViewModel());

class SearchViewModel extends ChangeNotifier {
  List<History> _histories = [];
  List<History> get histories => _histories;

  Future<void> addSearchHistory(
      Future<Database> database, String searchWord) async {
    final history = History(id: searchWord.hashCode, keyword: searchWord);
    final db = await database;
    await db.insert('history', history.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> getSearchHistories(Future<Database> database) async {
    final db = await database;
    final maps = await db.query('history');
    _histories = List.generate(maps.length, (index) {
      return History(
          id: int.parse(maps[index]['id'].toString()),
          keyword: maps[index]['keyword'].toString());
    });
    notifyListeners();
  }

  Future<void> deleteSearchHistories(Future<Database> database, int id) async {
    final db = await database;
    await db.delete('history', where: 'id = ?', whereArgs: [id]);
  }
}
