import 'package:avgleclient/data/provider/firebase_auth_provider.dart';
import 'package:avgleclient/data/provider/firebase_firestore_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final Provider<Stream<QuerySnapshot>>
    firebaseFirestoreRecentlyWatchedStreamProvider =
    Provider<Stream<QuerySnapshot>>((ref) => ref
        .read(firebaseFireStoreProvider)
        .collection(ref.read(firebaseAuthProvider).currentUser.uid)
        .doc('data')
        .collection('history')
        .limit(10)
        .orderBy('at_watched', descending: true)
        .snapshots());
