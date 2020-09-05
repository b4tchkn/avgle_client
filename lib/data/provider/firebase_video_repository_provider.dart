import 'package:avgleclient/data/provider/firebase_video_data_source_provider.dart';
import 'package:avgleclient/data/repository/firebase_video_repository.dart';
import 'package:avgleclient/data/repository/firebase_video_repository_impl.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final Provider<FirebaseVideoRepository> firebaseVideoRepositoryProvider =
    Provider<FirebaseVideoRepository>((ref) => FirebaseVideoRepositoryImpl(
        dataSource: ref.read(firebaseVideoDataSourceProvider)));
