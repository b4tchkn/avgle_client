import 'package:avgleclient/data/model/category_res.dart';
import 'package:avgleclient/data/provider/category_repository_provider.dart';
import 'package:avgleclient/data/repository/category_repository.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final exploreViewModelNotifierProvider = ChangeNotifierProvider((ref) =>
    ExploreViewModel(ref,
        categoryRepository: ref.read(categoryRepositoryProvider)));

class ExploreViewModel extends ChangeNotifier {
  ExploreViewModel(ProviderReference ref,
      {@required CategoryRepository categoryRepository})
      : _categoryRepository = categoryRepository;

  final CategoryRepository _categoryRepository;

  var _count = 0;
  int get count => _count;

  CategoryRes _categoryRes;
  CategoryRes get categoryRes => _categoryRes;

  final List<Category> _categories = [];
  List<Category> get categories => _categories;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void increment() {
    _count++;
    notifyListeners();
  }

  Future<CategoryRes> fetchCategories() {
    _isLoading = true;
    return _categoryRepository.fetchCategories().then((value) {
      _categoryRes = value;
      _categories.addAll(value.response.categories);
      _isLoading = false;
      notifyListeners();
    }).catchError((dynamic error) {
      debugPrint('fetchCategoriesError $error');
    });
  }
}
