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
    var result = _auth.currentUser;
    var googleSignOutResult = _googleSignIn.currentUser;
    var authSignOutResult = _auth.currentUser;

    try {
      if (_googleSignIn.currentUser != null && _auth.currentUser != null) {
        await _auth
            .signOut()
            .then((_) => {
                  debugPrint('signOut success'),
                  authSignOutResult = null,
                })
            .catchError((_) => {
                  debugPrint('auth signOut error'),
                });
        await _googleSignIn
            .signOut()
            .then((_) => {
                  googleSignOutResult = null,
                })
            .catchError((_) => {
                  debugPrint('google signOut error'),
                });
      }
      if (googleSignOutResult == null && authSignOutResult == null) {
        result = null;
      }
      debugPrint('signOut signedOut in $result');
      return result;
    } catch (e) {
      debugPrint(e.toString());
      return result;
    }
  }
}
