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

  final List<Video> _searchedVideos = [];
  List<Video> get searchedVideos => _searchedVideos;

  final List<String> _playlists = [];
  List<String> get playlists => _playlists;

  List<History> _histories = [];
  List<History> get histories => _histories;

  bool _isVideoHasMore = false;
  bool get isVideoHasMore => _isVideoHasMore;

  bool _isSearched = false;
  bool get isSearched => _isSearched;

  bool _isTextFieldEmply = true;
  bool get isTextFieldEmpty => _isTextFieldEmply;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  TextEditingController searchTextEditingController = TextEditingController();

  int _pageCount = -1;

  Future<void> addSearchHistory(
      Future<Database> database, String searchWord) async {
    final history = History(id: searchWord.hashCode, keyword: searchWord);
    final db = await database;
    await db.insert('history', history.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    await getSearchHistories(database);
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
    await getSearchHistories(database);
  }

  Future<void> searchVideos(String searchWord) async {
    _isLoading = true;
    _isSearched = true;
    _pageCount = 0;
    searchedVideos.clear();
    searchTextEditingController.text = searchWord;
    notifyListeners();
    return _videoRepository
        .fetchSearchedVideos(searchWord, _pageCount.toString())
        .then((value) {
      _isLoading = false;
      _isVideoHasMore = value.response.hasMore;
      _searchedVideos.addAll(value.response.videos);
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
      _searchedVideos.addAll(value.response.videos);
      notifyListeners();
    }).catchError((dynamic error) {
      debugPrint('fetchSearchVideos $error');
    });
  }

  Future<void> addVideoInWatchLater(Video video) {
    return _firebaseVideoRepository.addVideoInWatchLater(video);
  }

  Future<void> addVideoInHistory(Video video) {
    return _firebaseVideoRepository.addVideoInHistory(video);
  }

  Future<void> fetchPlaylists() {
    return _firebaseVideoRepository.fetchPlaylists().then((value) {
      _playlists.clear();
      _playlists.addAll(value);
      notifyListeners();
    }).catchError((dynamic error) {
      debugPrint('fetchPlaylists $error');
    });
  }

  Future<void> addVideoInPlaylist(String playlistName, Video video) {
    return _firebaseVideoRepository.addVideoInPlaylist(playlistName, video);
  }

  Future<void> createPlaylist(String playlistName, Video video) async {
    await _firebaseVideoRepository.createPlaylist(playlistName);
    return addVideoInPlaylist(playlistName, video);
  }

  void changeTextFieldState(bool isTextFieldEmpty) {
    _isTextFieldEmply = isTextFieldEmpty;
    if (isTextFieldEmpty) {
      _isSearched = false;
      notifyListeners();
    }
    notifyListeners();
  }

  void onTapTextFieldClear() {
    changeTextFieldState(true);
    searchTextEditingController.clear();
    _isSearched = false;
    notifyListeners();
  }

  @override
  void dispose() {
    searchTextEditingController.dispose();
    super.dispose();
  }

  void onWillPop() {
    _isSearched = false;
    _isTextFieldEmply = true;
    searchTextEditingController.clear();
    notifyListeners();
  }
}
