import 'package:avgleclient/data/model/video_res.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserDataSource {
  UserDataSource(
      {@required FirebaseAuth auth, @required FirebaseFirestore store})
      : _auth = auth,
        _store = store;

  final FirebaseAuth _auth;
  final FirebaseFirestore _store;
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

  Future<void> addVideoInWatchLater(Video video) {
    final userData = _store
        .collection(_auth.currentUser.uid)
        .doc('data')
        .collection('watch_later')
        .doc(video.uid);
    return userData.set(video.toJson());
  }
}
