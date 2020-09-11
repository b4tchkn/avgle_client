import 'package:avgleclient/data/model/category_res.dart';
import 'package:avgleclient/data/model/video_res.dart';
import 'package:avgleclient/data/provider/category_repository_provider.dart';
import 'package:avgleclient/data/provider/video_repository_provider.dart';
import 'package:avgleclient/data/repository/category_repository.dart';
import 'package:avgleclient/data/repository/video_repository.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final exploreViewModelNotifierProvider = ChangeNotifierProvider((ref) =>
    ExploreViewModel(ref,
        categoryRepository: ref.read(categoryRepositoryProvider),
        videoRepository: ref.read(videoRepositoryProvider)));

class ExploreViewModel extends ChangeNotifier {
  ExploreViewModel(ProviderReference ref,
      {@required CategoryRepository categoryRepository,
      @required VideoRepository videoRepository})
      : _categoryRepository = categoryRepository,
        _videoRepository = videoRepository;

  final CategoryRepository _categoryRepository;
  final VideoRepository _videoRepository;

  var _count = 0;
  int get count => _count;

  CategoryRes _categoryRes;
  CategoryRes get categoryRes => _categoryRes;

  List<Category> _categories = [];
  List<Category> get categories => _categories;

  final List<Video> _topJAVs = [];
  List<Video> get topJAVs => _topJAVs;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  int _pageCount = -1;

  void increment() {
    _count++;
    notifyListeners();
  }

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

  Future<VideoRes> fetchExploreTopJAVs() {
    _pageCount++;
    return _videoRepository
        .fetchSearchedVideos('JAV', _pageCount.toString())
        .then((value) {
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
    return fetchExploreTopJAVs();
  }
}
