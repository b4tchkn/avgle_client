import 'package:avgleclient/data/provider/firebase_auth_provider.dart';
import 'package:avgleclient/data/remote/user_data_source.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final Provider<UserDataSource> userDataSourceProvider =
    Provider<UserDataSource>(
        (ref) => UserDataSource(ref.read(firebaseAuthProvider)));
