import 'package:avgleclient/data/model/video_res.dart';
import 'package:avgleclient/data/provider/firebase_video_repository_provider.dart';
import 'package:avgleclient/data/provider/video_repository_provider.dart';
import 'package:avgleclient/data/repository/firebase_video_repository.dart';
import 'package:avgleclient/data/repository/video_repository.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final categoryViewModelNotifierProvider = ChangeNotifierProvider((ref) =>
    CategoryViewModel(ref,
        videoRepository: ref.read(videoRepositoryProvider),
        firebaseVideoRepository: ref.read(firebaseVideoRepositoryProvider)));

class CategoryViewModel extends ChangeNotifier {
  CategoryViewModel(ProviderReference ref,
      {@required VideoRepository videoRepository,
      @required FirebaseVideoRepository firebaseVideoRepository})
      : _videoRepository = videoRepository,
        _firebaseVideoRepository = firebaseVideoRepository;
  final VideoRepository _videoRepository;
  final FirebaseVideoRepository _firebaseVideoRepository;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isCategoryVideosHasMore = false;
  bool get isCategoryVideosHasMore => _isCategoryVideosHasMore;

  int _totalVideoCount = 0;
  int get totalVideoCount => _totalVideoCount;

  final List<Video> _categoryVideos = [];
  List<Video> get categoryVideos => _categoryVideos;

  int _pageCount = -1;

  Future<VideoRes> fetchCategoryVideos(String categoryName) {
    _pageCount++;
    _isLoading = true;
    return _videoRepository
        .fetchSearchedVideos(categoryName, _pageCount.toString())
        .then((value) {
      _totalVideoCount = value.response.totalVideos;
      _isCategoryVideosHasMore = value.response.hasMore;
      _categoryVideos.addAll(value.response.videos);
      _isLoading = false;
      notifyListeners();
    }).catchError((dynamic error) {
      debugPrint('fetchCategoryVideos $error');
    });
  }

  Future<void> onRefresh(String categoryName) {
    _pageCount = -1;
    _categoryVideos.clear();
    notifyListeners();
    return fetchCategoryVideos(categoryName);
  }

  Future<void> addVideoInHistory(Video video) {
    return _firebaseVideoRepository.addVideoInHistory(video);
  }

  Future<void> addVideoInWatchLater(Video video) {
    return _firebaseVideoRepository.addVideoInWatchLater(video);
  }
}
