import 'package:avgleclient/data/provider/category_data_source_provider.dart';
import 'package:avgleclient/data/repository/category_repository.dart';
import 'package:avgleclient/data/repository/category_repository_impl.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final Provider<CategoryRepository> categoryRepositoryProvider =
    Provider<CategoryRepository>((ref) => CategoryRepositoryImpl(
        dataSource: ref.read(categoryDataSourceProvider)));
