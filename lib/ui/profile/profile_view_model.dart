import 'package:avgleclient/data/provider/user_repository_provider.dart';
import 'package:avgleclient/data/repository/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final profileViewModelNotifierProvider = ChangeNotifierProvider((ref) =>
    ProfileViewModel(ref, repository: ref.read(userRepositoryProvider)));

class ProfileViewModel extends ChangeNotifier {
  ProfileViewModel(ProviderReference ref, {@required UserRepository repository})
      : _repository = repository;

  final UserRepository _repository;

  User _user;
  User get user => _user;

  Future<void> fetchUser() async {
    _user = await _repository.fetchUser();
    notifyListeners();
  }

  Future<void> signIn() async {
    _user = await _repository.signIn();
    notifyListeners();
  }

  Future<void> signOut() async {
    // ignore: unnecessary_parenthesis
    _user = await (_repository.signOut()) as User;
    notifyListeners();
  }
}
