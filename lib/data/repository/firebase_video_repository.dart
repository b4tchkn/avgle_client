import 'package:avgleclient/data/model/video_res.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class FirebaseVideoRepository {
  Future<void> addVideoInWatchLater(Video video);
  Future<void> addVideoInHistory(Video video);
  Future<QuerySnapshot> fetchRecentlyWatchedVideos();
}
