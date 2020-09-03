import 'package:avgleclient/data/remote/user_data_source.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final Provider<UserDataSource> userDataSourceProvider =
    Provider<UserDataSource>((ref) => UserDataSource());
