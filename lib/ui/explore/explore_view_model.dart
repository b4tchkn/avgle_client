import 'package:avgleclient/data/model/category_res.dart';
import 'package:avgleclient/data/model/video_res.dart';
import 'package:avgleclient/data/provider/category_repository_provider.dart';
import 'package:avgleclient/data/provider/firebase_video_repository_provider.dart';
import 'package:avgleclient/data/provider/video_repository_provider.dart';
import 'package:avgleclient/data/repository/category_repository.dart';
import 'package:avgleclient/data/repository/firebase_video_repository.dart';
import 'package:avgleclient/data/repository/video_repository.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final exploreViewModelNotifierProvider = ChangeNotifierProvider((ref) =>
    ExploreViewModel(ref,
        categoryRepository: ref.read(categoryRepositoryProvider),
        videoRepository: ref.read(videoRepositoryProvider),
        firebaseVideoRepository: ref.read(firebaseVideoRepositoryProvider)));

class ExploreViewModel extends ChangeNotifier {
  ExploreViewModel(ProviderReference ref,
      {@required CategoryRepository categoryRepository,
      @required VideoRepository videoRepository,
      @required FirebaseVideoRepository firebaseVideoRepository})
      : _categoryRepository = categoryRepository,
        _videoRepository = videoRepository,
        _firebaseVideoRepository = firebaseVideoRepository;

  final CategoryRepository _categoryRepository;
  final VideoRepository _videoRepository;
  final FirebaseVideoRepository _firebaseVideoRepository;

  CategoryRes _categoryRes;
  CategoryRes get categoryRes => _categoryRes;

  List<Category> _categories = [];
  List<Category> get categories => _categories;

  final List<Video> _topJAVs = [];
  List<Video> get topJAVs => _topJAVs;

  final List<String> _playlists = [];
  List<String> get playlists => _playlists;

  bool _isTopJAVsHasMore = false;
  bool get isTopJAVsHasMore => _isTopJAVsHasMore;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  int _pageCount = -1;

  Future<CategoryRes> fetchCategories() {
    _isLoading = true;
    return _categoryRepository.fetchCategories().then((value) {
      _categoryRes = value;
      _categories = value.response.categories;
      _isLoading = false;
      notifyListeners();
    }).catchError((dynamic error) {
      debugPrint('fetchCategoriesError $error');
    });
  }

  Future<VideoRes> fetchTopJAVs() {
    _pageCount++;
    return _videoRepository
        .fetchSearchedVideos('JAV', _pageCount.toString())
        .then((value) {
      _isTopJAVsHasMore = value.response.hasMore;
      _topJAVs.addAll(value.response.videos);
      notifyListeners();
    }).catchError((dynamic error) {
      debugPrint('fetchExploreTopJAVs $error');
    });
  }

  Future<void> onRefresh() {
    _pageCount = -1;
    _topJAVs.clear();
    notifyListeners();
    return fetchTopJAVs();
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
}
