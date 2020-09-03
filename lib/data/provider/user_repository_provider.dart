import 'package:avgleclient/data/provider/user_data_source_provider.dart';
import 'package:avgleclient/data/repository/user_repository.dart';
import 'package:avgleclient/data/repository/user_reposotory_impl.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final Provider<UserRepository> userRepositoryProvider =
    Provider<UserRepository>((ref) =>
        UserRepositoryImpl(dataSource: ref.read(userDataSourceProvider)));
