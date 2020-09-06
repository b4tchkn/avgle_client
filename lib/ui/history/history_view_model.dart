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

  TextEditingController searchTextEditingController = TextEditingController();

  Future<void> addVideoInHistory(Video video) {
    return _firebaseVideoRepository.addVideoInHistory(video);
  }

  Future<void> fetchHistoryVideos() async {
    _isLoading = true;
    _videos = await _firebaseVideoRepository.fetchHistoryVideos();
    videos = await _firebaseVideoRepository.fetchHistoryVideos();
    _isLoading = false;
    notifyListeners();
  }

  Future<void> refresh() {
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

  @override
  void dispose() {
    searchTextEditingController.dispose();
    super.dispose();
  }
}
