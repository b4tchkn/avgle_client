import 'package:avgleclient/data/model/video_res.dart';
import 'package:avgleclient/data/provider/user_repository_provider.dart';
import 'package:avgleclient/data/provider/video_repository_provider.dart';
import 'package:avgleclient/data/repository/user_repository.dart';
import 'package:avgleclient/data/repository/video_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final homeViewModelNotifierProvider = ChangeNotifierProvider((ref) =>
    HomeViewModel(ref,
        videoRepository: ref.read(videoRepositoryProvider),
        userRepository: ref.read(userRepositoryProvider)));

class HomeViewModel extends ChangeNotifier {
  HomeViewModel(ProviderReference ref,
      {@required VideoRepository videoRepository,
      @required UserRepository userRepository})
      : _videoRepository = videoRepository,
        _userRepository = userRepository;

  final VideoRepository _videoRepository;
  final UserRepository _userRepository;

  VideoRes _videoRes;
  VideoRes get videoRes => _videoRes;

  final List<Video> _videos = [];
  List<Video> get videos => _videos;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  int _pageCount = -1;

  Future<VideoRes> getVideos() async {
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
    return getVideos();
  }

  Future<void> addVideoInWatchLater(Video video) {
    return _userRepository.addVideoInWatchLater(video);
  }
}
