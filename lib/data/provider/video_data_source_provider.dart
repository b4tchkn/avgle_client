import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:avgleclient/data/remote/video_data_source.dart';

import 'dio_provider.dart';

final Provider<VideoDataSource> videoDataSourceProvider =
    Provider<VideoDataSource>((ref) => VideoDataSource(ref.read(dioProvider)));
