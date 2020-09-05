import 'package:firebase_auth/firebase_auth.dart';

abstract class UserRepository {
  Future<User> fetchUser();
  Future<User> signIn();
  Future<User> signOut();
}
