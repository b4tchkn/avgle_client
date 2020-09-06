import 'package:avgleclient/constants.dart';
import 'package:avgleclient/data/model/category_res.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

part 'category_data_source.g.dart';

@RestApi(baseUrl: Constants.baseUrl)
abstract class CategoryDataSource {
  factory CategoryDataSource(Dio dio, {String baseUrl}) = _CategoryDataSource;
  @GET('/categories')
  Future<CategoryRes> fetchCategories();
}
