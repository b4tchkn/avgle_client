import 'package:avgleclient/data/model/video_res.dart';
import 'package:avgleclient/data/provider/firebase_video_repository_provider.dart';
import 'package:avgleclient/data/provider/user_repository_provider.dart';
import 'package:avgleclient/data/repository/firebase_video_repository.dart';
import 'package:avgleclient/data/repository/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  User _user;
  User get user => _user;

  List<Video> _recentlyWatchedVideos = [];
  List<Video> get recentlyWatchedVideos => _recentlyWatchedVideos;

  Future<void> fetchUser() async {
    _isLoading = true;
    _user = await _userRepository.fetchUser();
    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchRecentlyWatchedVideos() async {
    _recentlyWatchedVideos =
        await _firebaseVideoRepository.fetchRecentlyWatchedVideos();
    notifyListeners();
  }
}
