import 'package:avgleclient/data/model/video_res.dart';
import 'package:avgleclient/data/provider/firebase_video_repository_provider.dart';
import 'package:avgleclient/data/repository/firebase_video_repository.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final watchLaterViewModelNotifierProvider = ChangeNotifierProvider((ref) =>
    WatchLaterViewModel(ref,
        firebaseVideoRepository: ref.read(firebaseVideoRepositoryProvider)));

class WatchLaterViewModel extends ChangeNotifier {
  WatchLaterViewModel(ProviderReference ref,
      {@required FirebaseVideoRepository firebaseVideoRepository})
      : _firebaseVideoRepository = firebaseVideoRepository;

  final FirebaseVideoRepository _firebaseVideoRepository;

  List<Video> _videos = [];
  List<Video> get videos => _videos;

  final List<String> _playlists = [];
  List<String> get playlists => _playlists;

  Future<void> fetchWatchLaterVideos() async {
    _videos = await _firebaseVideoRepository.fetchWatchLaterVideos();
    notifyListeners();
  }

  Future<void> addVideoInHistory(Video video) {
    return _firebaseVideoRepository.addVideoInHistory(video);
  }

  Future<void> fetchPlaylists() {
    return _firebaseVideoRepository.fetchPlaylists().then((value) {
      _playlists.clear();
      _playlists.addAll(value);
      notifyListeners();
    }).catchError((dynamic error) {
      debugPrint('fetchPlaylists $error');
    });
  }

  Future<void> addVideoInPlaylist(String playlistName, Video video) {
    return _firebaseVideoRepository.addVideoInPlaylist(playlistName, video);
  }

  Future<void> createPlaylist(String playlistName, Video video) async {
    await _firebaseVideoRepository.createPlaylist(playlistName);
    return addVideoInPlaylist(playlistName, video);
  }
}
