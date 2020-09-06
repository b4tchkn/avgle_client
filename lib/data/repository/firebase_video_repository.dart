import 'package:avgleclient/data/model/video_res.dart';

abstract class FirebaseVideoRepository {
  Future<void> addVideoInWatchLater(Video video);
  Future<void> addVideoInHistory(Video video);
  Future<List<Video>> fetchRecentlyWatchedVideos();
  Future<List<Video>> fetchWatchLaterVideos();
  Future<List<Video>> fetchHistoryVideos();
}
