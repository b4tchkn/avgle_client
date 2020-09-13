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

  @override
  Future<void> addVideoInHistory(Video video) {
    return _dataSource.addVideoInHistory(video);
  }

  @override
  Future<List<Video>> fetchRecentlyWatchedVideos() {
    return _dataSource.fetchRecentlyWatchedVideos();
  }

  @override
  Future<List<Video>> fetchWatchLaterVideos() {
    return _dataSource.fetchWatchLaterVideos();
  }

  @override
  Future<List<Video>> fetchHistoryVideos() {
    return _dataSource.fetchHistoryVideos();
  }

  @override
  Future<List<String>> fetchPlaylists() {
    return _dataSource.fetchPlaylists();
  }

  @override
  Future<void> addVideoInPlaylist(String playlistName, Video video) {
    return _dataSource.addVideoInPlaylist(playlistName, video);
  }
}
