import 'package:avgleclient/data/model/video_res.dart';
import 'package:avgleclient/data/provider/firebase_video_repository_provider.dart';
import 'package:avgleclient/data/repository/firebase_video_repository.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final historyViewModelNotifierProvider = ChangeNotifierProvider((ref) =>
    HistoryViewModel(ref,
        firebaseVideoRepository: ref.read(firebaseVideoRepositoryProvider)));

class HistoryViewModel extends ChangeNotifier {
  HistoryViewModel(ProviderReference ref,
      {@required FirebaseVideoRepository firebaseVideoRepository})
      : _firebaseVideoRepository = firebaseVideoRepository;

  final FirebaseVideoRepository _firebaseVideoRepository;

  List<Video> _videos = [];
  List<Video> videos = [];

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final List<String> _playlists = [];
  List<String> get playlists => _playlists;

  TextEditingController searchTextEditingController = TextEditingController();

  Future<void> addVideoInHistory(Video video) {
    return _firebaseVideoRepository.addVideoInHistory(video);
  }

  Future<void> fetchHistoryVideos() async {
    _isLoading = true;
    searchTextEditingController.text = '';
    _videos = await _firebaseVideoRepository.fetchHistoryVideos();
    videos = await _firebaseVideoRepository.fetchHistoryVideos();
    _isLoading = false;
    notifyListeners();
  }

  Future<void> refresh() {
    searchTextEditingController.text = '';
    _videos.clear();
    notifyListeners();
    return fetchHistoryVideos();
  }

  Future<void> addVideoInWatchLater(Video video) {
    return _firebaseVideoRepository.addVideoInWatchLater(video);
  }

  void searchHistoryVideos() {
    debugPrint(searchTextEditingController.text);
    final searchText = searchTextEditingController.text;
    final searchResult =
        _videos.where((video) => video.title.contains(searchText)).toList();
    videos = searchResult;
    notifyListeners();
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

  @override
  void dispose() {
    searchTextEditingController.dispose();
    super.dispose();
  }
}
