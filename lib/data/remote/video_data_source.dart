import 'package:avgleclient/constants.dart';
import 'package:avgleclient/data/model/video_res.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

part 'video_data_source.g.dart';

@RestApi(baseUrl: Constants.baseUrl)
abstract class VideoDataSource {
  factory VideoDataSource(Dio dio, {String baseUrl}) = _VideoDataSource;
  @GET('/videos/{page}')
  Future<VideoRes> fetchVideos(@Path('page') String page);
}
