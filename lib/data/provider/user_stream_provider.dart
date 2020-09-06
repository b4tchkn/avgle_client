import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final Provider<Stream<User>> userStreamProvider =
    Provider<Stream<User>>((_) => FirebaseAuth.instance.authStateChanges());
