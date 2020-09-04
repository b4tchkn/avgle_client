import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserDataSource {
  final auth = FirebaseAuth.instance;
  final googleSignIn = GoogleSignIn();

  Future<User> getUser() async {
    return auth.currentUser;
  }

  Future<User> signIn() async {
    var currentUser = googleSignIn.currentUser;
    try {
      currentUser ??= await googleSignIn.signIn();

      final googleAuth = await currentUser.authentication;
      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
      final user = (await auth.signInWithCredential(credential)).user;
      debugPrint('signIn signed in $user');
      return user;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<GoogleSignInAccount> signOut() async {
    var currentUser = googleSignIn.currentUser;
    try {
      if (currentUser != null) {
        await googleSignIn.signOut().then(
            (value) => {currentUser = value, debugPrint('signOut $value')});
      }
      return currentUser;
    } catch (e) {
      debugPrint(e.toString());
      return currentUser;
    }
  }
}
