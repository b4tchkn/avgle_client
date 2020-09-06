import 'package:avgleclient/data/model/category_res.dart';

abstract class CategoryRepository {
  Future<CategoryRes> fetchCategories();
}
