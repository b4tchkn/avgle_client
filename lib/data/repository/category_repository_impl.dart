import 'package:avgleclient/data/model/category_res.dart';
import 'package:avgleclient/data/remote/category_data_source.dart';
import 'package:avgleclient/data/repository/category_repository.dart';
import 'package:flutter/cupertino.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  CategoryRepositoryImpl({@required CategoryDataSource dataSource})
      : _dataSource = dataSource;

  final CategoryDataSource _dataSource;
  @override
  Future<CategoryRes> fetchCategory() {
    return _dataSource.fetchCategories();
  }
}
