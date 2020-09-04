import 'package:avgleclient/data/model/video_res.dart';
import 'package:avgleclient/data/remote/video_data_source.dart';
import 'package:avgleclient/data/repository/video_repository.dart';
import 'package:flutter/cupertino.dart';

class VideoRepositoryImpl implements VideoRepository {
  VideoRepositoryImpl({@required VideoDataSource dataSource})
      : _dataSource = dataSource;

  final VideoDataSource _dataSource;

  @override
  Future<VideoRes> fetchVideos(page) async {
    return _dataSource.fetchVideos(page);
  }
}
