import 'package:avgleclient/data/model/video_res.dart';
import 'package:avgleclient/data/provider/firebase_video_repository_provider.dart';
import 'package:avgleclient/data/repository/firebase_video_repository.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final playlistViewModelNotifierProvider = ChangeNotifierProvider((ref) =>
    PlaylistViewModel(ref,
        firebaseVideoRepository: ref.read(firebaseVideoRepositoryProvider)));

class PlaylistViewModel extends ChangeNotifier {
  PlaylistViewModel(ref,
      {@required FirebaseVideoRepository firebaseVideoRepository})
      : _firebaseVideoRepository = firebaseVideoRepository;

  final FirebaseVideoRepository _firebaseVideoRepository;

  List<Video> _videos = [];
  List<Video> get videos => _videos;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> fetchPlaylistVideos(String playlistName) async {
    _isLoading = true;
    _videos = await _firebaseVideoRepository.fetchPlaylistVideos(playlistName);
    _isLoading = false;
    notifyListeners();
  }

  Future<void> deleteVideoInPlaylist(String vid, String playlistName) {
    return _firebaseVideoRepository.deleteVideoInPlaylist(vid, playlistName);
  }

  Future<void> addVideoInHistory(Video video) {
    return _firebaseVideoRepository.addVideoInHistory(video);
  }

  Future<void> addVideoInWatchLater(Video video) {
    return _firebaseVideoRepository.addVideoInWatchLater(video);
  }
}
