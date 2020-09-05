import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class UserRepository {
  Future<User> fetchUser();
  Future<User> signIn();
  Future<GoogleSignInAccount> signOut();
}
