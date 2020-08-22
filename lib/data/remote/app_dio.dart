import 'package:avgleclient/constants.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';

class AppDio with DioMixin implements Dio {
  AppDio._([BaseOptions options]) {
    options = BaseOptions(
      baseUrl: Constants.baseUrl,
      contentType: 'application/json',
      connectTimeout: 30000,
      sendTimeout: 30000,
      receiveTimeout: 30000,
    );

    this.options = options;
    interceptors
      ..add(DioCacheManager(CacheConfig(baseUrl: Constants.baseUrl)).interceptor
          as Interceptor)
      ..add(LogInterceptor(responseBody: true));
    httpClientAdapter = DefaultHttpClientAdapter();
  }

  static Dio getInstance() => AppDio._();
}
