import 'package:avgleclient/data/model/video_res.dart';
import 'package:avgleclient/data/provider/firebase_video_repository_provider.dart';
import 'package:avgleclient/data/provider/video_repository_provider.dart';
import 'package:avgleclient/data/repository/firebase_video_repository.dart';
import 'package:avgleclient/data/repository/video_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final homeViewModelNotifierProvider = ChangeNotifierProvider((ref) =>
    HomeViewModel(ref,
        videoRepository: ref.read(videoRepositoryProvider),
        firebaseVideoRepository: ref.read(firebaseVideoRepositoryProvider)));

class HomeViewModel extends ChangeNotifier {
  HomeViewModel(ProviderReference ref,
      {@required VideoRepository videoRepository,
      @required FirebaseVideoRepository firebaseVideoRepository})
      : _videoRepository = videoRepository,
        _firebaseVideoRepository = firebaseVideoRepository;

  final VideoRepository _videoRepository;
  final FirebaseVideoRepository _firebaseVideoRepository;

  VideoRes _videoRes;
  VideoRes get videoRes => _videoRes;

  final List<Video> _videos = [];
  List<Video> get videos => _videos;

  final List<String> _playlists = [];
  List<String> get playLists => _playlists;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  int _pageCount = -1;

  Future<VideoRes> fetchVideos() async {
    _pageCount++;
    _isLoading = true;
    return _videoRepository.fetchVideos(_pageCount.toString()).then((value) {
      _videoRes = value;
      _videos.addAll(value.response.videos);
      _isLoading = false;
      notifyListeners();
    }).catchError((dynamic error) {
      debugPrint('getVideoError $error');
    });
  }

  Future<void> refreshAndGetVideos() {
    _pageCount = -1;
    _videos.clear();
    notifyListeners();
    return fetchVideos();
  }

  Future<void> addVideoInWatchLater(Video video) {
    return _firebaseVideoRepository.addVideoInWatchLater(video);
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
