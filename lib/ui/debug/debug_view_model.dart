import 'package:avgleclient/data/provider/user_repository_provider.dart';
import 'package:avgleclient/data/repository/user_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final debugViewModelNotifierProvider = ChangeNotifierProvider(
    (ref) => DebugViewModel(ref, repository: ref.read(userRepositoryProvider)));

class DebugViewModel extends ChangeNotifier {
  DebugViewModel(ProviderReference ref, {@required UserRepository repository})
      : _repository = repository;
  final UserRepository _repository;

  Future<void> signIn() async {
    final result = await _repository.signIn();
    debugPrint(result.toString());
  }

  void signOut() {
    _repository.signOut();
  }
}
