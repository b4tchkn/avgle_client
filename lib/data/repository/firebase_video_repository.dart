import 'package:avgleclient/data/model/video_res.dart';

abstract class FirebaseVideoRepository {
  Future<void> addVideoInWatchLater(Video video);
}
