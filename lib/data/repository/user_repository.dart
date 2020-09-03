import 'package:firebase_auth/firebase_auth.dart';

abstract class UserRepository {
  Future<User> getUser();
  Future<User> signIn();
  void signOut();
}
