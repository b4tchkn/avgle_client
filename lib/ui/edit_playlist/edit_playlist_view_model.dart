import 'package:avgleclient/data/model/video_res.dart';
import 'package:avgleclient/data/provider/firebase_video_repository_provider.dart';
import 'package:avgleclient/data/repository/firebase_video_repository.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final editPlaylistViewModelNotifierProvider = ChangeNotifierProvider((ref) =>
    EditPlaylistViewModel(ref,
        firebaseVideoRepository: ref.read(firebaseVideoRepositoryProvider)));

class EditPlaylistViewModel extends ChangeNotifier {
  EditPlaylistViewModel(ref,
      {@required FirebaseVideoRepository firebaseVideoRepository})
      : _firebaseVideoRepository = firebaseVideoRepository;

  final FirebaseVideoRepository _firebaseVideoRepository;

  Video _video;
  Video get video => _video;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> updatePlaylistName(
      String oldPlaylistName, String newPlaylistName) {
    return _firebaseVideoRepository.updatePlaylistName(
        oldPlaylistName, newPlaylistName);
  }

  Future<void> fetchPlaylistTopOneVideo(String playlistName) async {
    _isLoading = true;
    _video =
        await _firebaseVideoRepository.fetchPlaylistTopOneVideo(playlistName);
    _isLoading = false;
    notifyListeners();
  }
}
