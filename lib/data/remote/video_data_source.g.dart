// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_data_source.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _VideoDataSource implements VideoDataSource {
  _VideoDataSource(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    this.baseUrl ??= 'https://api.avgle.com/v1';
  }

  final Dio _dio;

  String baseUrl;

  @override
  fetchVideos(page) async {
    ArgumentError.checkNotNull(page, 'page');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/videos/$page',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = VideoRes.fromJson(_result.data);
    return value;
  }

  @override
  fetchSearchedVideos(query, page) async {
    ArgumentError.checkNotNull(query, 'query');
    ArgumentError.checkNotNull(page, 'page');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/search/$query/$page',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = VideoRes.fromJson(_result.data);
    return value;
  }
}
