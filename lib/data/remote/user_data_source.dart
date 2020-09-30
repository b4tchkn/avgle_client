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
    try {
      await _googleSignIn.signIn();

      final googleAuth = await _googleSignIn.currentUser.authentication;
      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
      final user = (await _auth.signInWithCredential(credential)).user;
      debugPrint('signIn signed in $user');
      return user;
    } catch (e) {
      debugPrint(e.toString());
      return _auth.currentUser;
    }
  }

  Future<User> signOut() async {
    var authCurrentUser = _auth.currentUser;
    var googleCurrentUser = _googleSignIn.currentUser;

    if (authCurrentUser != null) {
      await _auth.signOut().then((value) {
        authCurrentUser = value as User;
      }).catchError((_) {
        debugPrint('auth signOut error');
      });
    }

    if (googleCurrentUser != null) {
      await _googleSignIn.signOut().then((value) {
        googleCurrentUser = value;
      }).catchError((_) {
        debugPrint('google sighOut error');
      });
    }
    return authCurrentUser;
  }
}
