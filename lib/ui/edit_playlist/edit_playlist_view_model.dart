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

  Future<void> updatePlaylistName(
      String oldPlaylistName, String newPlaylistName) {
    return _firebaseVideoRepository.updatePlaylistName(
        oldPlaylistName, newPlaylistName);
  }
}
