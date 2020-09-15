import 'package:avgleclient/data/model/video_res.dart';

abstract class FirebaseVideoRepository {
  Future<void> addVideoInWatchLater(Video video);
  Future<void> addVideoInHistory(Video video);
  Future<List<Video>> fetchRecentlyWatchedVideos();
  Future<List<Video>> fetchWatchLaterVideos();
  Future<List<Video>> fetchHistoryVideos();
  Future<List<String>> fetchPlaylists();
  Future<List<Video>> fetchPlaylistVideos(String playlistName);
  Future<Video> fetchPlaylistTopOneVideo(String playlistName);
  Future<void> addVideoInPlaylist(String playlistName, Video video);
  Future<void> createPlaylist(String playlistName);
  Future<void> deleteVideoInHistory(String vid);
  Future<void> deleteVideoInWatchLater(String vid);
  Future<void> deletePlaylist(String playlistName);
  Future<void> deleteVideoInPlaylist(String vid, String playlistName);
  Future<void> updatePlaylistName(
      String oldPlaylistName, String newPlaylistName);
}
