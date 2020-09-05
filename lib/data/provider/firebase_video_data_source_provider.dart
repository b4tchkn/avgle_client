import 'package:avgleclient/data/provider/firebase_auth_provider.dart';
import 'package:avgleclient/data/provider/firebase_firestore_provider.dart';
import 'package:avgleclient/data/remote/firebase_video_data_source.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final Provider<FirebaseVideoDataSource> firebaseVideoDataSourceProvider =
    Provider<FirebaseVideoDataSource>((ref) => FirebaseVideoDataSource(
        auth: ref.read(firebaseAuthProvider),
        store: ref.read(firebaseFireStoreProvider)));
