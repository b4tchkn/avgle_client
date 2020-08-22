import 'package:avgleclient/data/provider/video_data_source_provider.dart';
import 'package:avgleclient/data/repository/video_repository.dart';
import 'package:avgleclient/data/repository/video_repository_impl.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final Provider<VideoRepository> videoRepositoryProvider =
    Provider<VideoRepository>((ref) =>
        VideoRepositoryImpl(dataSource: ref.read(videoDataSourceProvider)));
