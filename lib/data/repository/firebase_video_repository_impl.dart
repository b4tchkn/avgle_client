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
  Future<List<Video>> fetchPlaylistVideos(String playlistName) {
    return _dataSource.fetchPlaylistVideos(playlistName);
  }

  @override
  Future<List<String>> fetchPlaylists() {
    return _dataSource.fetchPlaylists();
  }

  @override
  Future<void> addVideoInPlaylist(String playlistName, Video video) {
    return _dataSource.addVideoInPlaylist(playlistName, video);
  }

  @override
  Future<void> createPlaylist(String playlistName) {
    return _dataSource.createPlaylist(playlistName);
  }

  @override
  Future<void> deleteVideoInHistory(String vid) {
    return _dataSource.deleteVideoInHistory(vid);
  }

  @override
  Future<void> deleteVideoInPlaylist(String vid, String playlistName) {
    return _dataSource.deleteVideoInPlaylist(vid, playlistName);
  }

  @override
  Future<void> deleteVideoInWatchLater(String vid) {
    return _dataSource.deleteVideoInWatchLater(vid);
  }

  @override
  Future<void> updatePlaylistName(
      String oldPlaylistName, String newPlaylistName) {
    return _dataSource.updatePlaylistName(oldPlaylistName, newPlaylistName);
  }
}
