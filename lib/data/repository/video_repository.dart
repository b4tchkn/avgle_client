import 'package:avgleclient/data/model/video_res.dart';

abstract class VideoRepository {
  Future<VideoRes> fetchVideos(String page);
  Future<VideoRes> fetchSearchedVideos(String query, String page);
}
