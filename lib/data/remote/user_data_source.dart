import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserDataSource {
  UserDataSource({@required FirebaseAuth auth}) : _auth = auth;

  final FirebaseAuth _auth;
  final _googleSignIn = GoogleSignIn();

  Future<User> fetchUser() async {
    return _auth.currentUser;
  }

  Future<User> signIn() async {
    var currentUser = _googleSignIn.currentUser;
    try {
      currentUser ??= await _googleSignIn.signIn();

      final googleAuth = await currentUser.authentication;
      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
      final user = (await _auth.signInWithCredential(credential)).user;
      debugPrint('signIn signed in $user');
      return user;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<GoogleSignInAccount> signOut() async {
    var currentUser = _googleSignIn.currentUser;
    try {
      if (currentUser != null) {
        await _googleSignIn.signOut().then(
            (value) => {currentUser = value, debugPrint('signOut $value')});
      }
      return currentUser;
    } catch (e) {
      debugPrint(e.toString());
      return currentUser;
    }
  }
}
