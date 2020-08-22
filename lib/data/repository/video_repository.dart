import 'package:avgleclient/data/model/video_res.dart';

abstract class VideoRepository {
  Future<VideoRes> getVideos();
}
