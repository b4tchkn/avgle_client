import 'package:avgleclient/data/model/video_res.dart';
import 'package:avgleclient/data/provider/video_repository_provider.dart';
import 'package:avgleclient/data/repository/video_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final homeViewModelNotifierProvider = ChangeNotifierProvider(
    (ref) => HomeViewModel(ref, repository: ref.read(videoRepositoryProvider)));

class HomeViewModel extends ChangeNotifier {
  HomeViewModel(ProviderReference ref, {@required VideoRepository repository})
      : _repository = repository;

  final VideoRepository _repository;

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
    return _repository.getVideos(_pageCount.toString()).then((value) {
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
}
