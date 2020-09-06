// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_data_source.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _CategoryDataSource implements CategoryDataSource {
  _CategoryDataSource(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    this.baseUrl ??= 'https://api.avgle.com/v1';
  }

  final Dio _dio;

  String baseUrl;

  @override
  fetchCategories() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/categories',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = CategoryRes.fromJson(_result.data);
    return value;
  }
}
