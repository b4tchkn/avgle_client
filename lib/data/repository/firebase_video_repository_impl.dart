import 'package:avgleclient/data/model/video_res.dart';
import 'package:avgleclient/data/remote/firebase_video_data_source.dart';
import 'package:avgleclient/data/repository/firebase_video_repository.dart';
import 'package:flutter/cupertino.dart';

class FirebaseVideoRepositoryImpl implements FirebaseVideoRepository {
  FirebaseVideoRepositoryImpl({@required FirebaseVideoDataSource dataSource})
      : _dataSource = dataSource;

  final FirebaseVideoDataSource _dataSource;
  @override
  Future<void> addVideoInWatchLater(Video video) {
    return _dataSource.addVideoInWatchLater(video);
  }
}
