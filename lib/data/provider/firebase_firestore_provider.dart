import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final Provider<FirebaseFirestore> firebaseFireStoreProvider =
    Provider<FirebaseFirestore>((_) => FirebaseFirestore.instance);
