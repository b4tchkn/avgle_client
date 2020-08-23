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
  bool isLoading = false;
  List<Video> _videos;
  List<Video> get videos => _videos;

  Future<VideoRes> getVideos(String page) async {
    isLoading = true;
    notifyListeners();
    return _repository.getVideos(page).then((value) {
      isLoading = false;
      _videoRes = value;
      return _videoRes = value;
    }).catchError((dynamic error) {});
  }
}
