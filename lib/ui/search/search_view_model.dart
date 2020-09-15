import 'package:avgleclient/data/model/history.dart';
import 'package:avgleclient/data/model/video_res.dart';
import 'package:avgleclient/data/provider/firebase_video_repository_provider.dart';
import 'package:avgleclient/data/provider/video_repository_provider.dart';
import 'package:avgleclient/data/repository/firebase_video_repository.dart';
import 'package:avgleclient/data/repository/video_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sqflite/sqflite.dart';

final searchViewModelNotifierProvider = ChangeNotifierProvider((ref) =>
    SearchViewModel(ref,
        firebaseVideoRepository: ref.read(firebaseVideoRepositoryProvider),
        videoRepository: ref.read(videoRepositoryProvider)));

class SearchViewModel extends ChangeNotifier {
  SearchViewModel(ProviderReference ref,
      {@required FirebaseVideoRepository firebaseVideoRepository,
      @required VideoRepository videoRepository})
      : _firebaseVideoRepository = firebaseVideoRepository,
        _videoRepository = videoRepository;

  final FirebaseVideoRepository _firebaseVideoRepository;
  final VideoRepository _videoRepository;

  List<Video> _searchedVidesos = [];
  List<Video> get searchedVideos => _searchedVidesos;

  List<History> _histories = [];
  List<History> get histories => _histories;

  bool _isVideoHasMore = false;
  bool get isVideoHasMore => _isVideoHasMore;

  bool _isSearched = false;
  bool get isSearched => _isSearched;

  int _pageCount = -1;

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

  Future<void> searchVideos(String searchWord) {
    _pageCount++;
    return _videoRepository
        .fetchSearchedVideos(searchWord, _pageCount.toString())
        .then((value) {
      _isVideoHasMore = value.response.hasMore;
      _searchedVidesos.addAll(value.response.videos);
      _isSearched = true;
      notifyListeners();
    }).catchError((dynamic error) {
      debugPrint('searchVideos $error');
    });
  }

  Future<void> fetchSearchedVideos(String searchWord) {
    _pageCount++;
    return _videoRepository
        .fetchSearchedVideos(searchWord, _pageCount.toString())
        .then((value) {
      _isVideoHasMore = value.response.hasMore;
      _searchedVidesos.addAll(value.response.videos);
      notifyListeners();
    }).catchError((dynamic error) {
      debugPrint('fetchSearchVideos $error');
    });
  }

  void onWillPop() {
    _isSearched = false;
    notifyListeners();
  }
}
