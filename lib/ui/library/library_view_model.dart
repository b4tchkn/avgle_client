import 'package:avgleclient/data/model/video_res.dart';
import 'package:avgleclient/data/provider/firebase_video_repository_provider.dart';
import 'package:avgleclient/data/provider/user_repository_provider.dart';
import 'package:avgleclient/data/repository/firebase_video_repository.dart';
import 'package:avgleclient/data/repository/user_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final libraryViewModelNotifierProvider = ChangeNotifierProvider((ref) =>
    LibraryViewModel(ref,
        userRepository: ref.read(userRepositoryProvider),
        firebaseVideoRepository: ref.read(firebaseVideoRepositoryProvider)));

class LibraryViewModel extends ChangeNotifier {
  LibraryViewModel(ProviderReference ref,
      {@required UserRepository userRepository,
      @required FirebaseVideoRepository firebaseVideoRepository})
      : _userRepository = userRepository,
        _firebaseVideoRepository = firebaseVideoRepository;

  final UserRepository _userRepository;
  final FirebaseVideoRepository _firebaseVideoRepository;

  bool _isLoadingRecentlyWatchedLaterVideo = false;
  bool get isLoadingRecentlyWatchedLaterVideo =>
      _isLoadingRecentlyWatchedLaterVideo;

  List<Video> _recentlyWatchedVideos = [];
  List<Video> get recentlyWatchedVideos => _recentlyWatchedVideos;

  Future<void> signIn() {
    return _userRepository.signIn();
  }

  Future<void> fetchRecentlyWatchedVideos() async {
    _isLoadingRecentlyWatchedLaterVideo = true;
    _recentlyWatchedVideos =
        await _firebaseVideoRepository.fetchRecentlyWatchedVideos();
    _isLoadingRecentlyWatchedLaterVideo = false;
    notifyListeners();
  }
}
