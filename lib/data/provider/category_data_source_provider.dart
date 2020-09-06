import 'package:avgleclient/data/provider/dio_provider.dart';
import 'package:avgleclient/data/remote/category_data_source.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final Provider<CategoryDataSource> categoryDataSourceProvider =
    Provider<CategoryDataSource>(
        (ref) => CategoryDataSource(ref.read(dioProvider)));
