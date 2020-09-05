import 'package:avgleclient/data/model/video_res.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class FirebaseVideoDataSource {
  FirebaseVideoDataSource(
      {@required FirebaseAuth auth, @required FirebaseFirestore store})
      : _auth = auth,
        _store = store;

  final FirebaseAuth _auth;
  final FirebaseFirestore _store;

  Future<void> addVideoInWatchLater(Video video) {
    final userDataRef = _store
        .collection(_auth.currentUser.uid)
        .doc('data')
        .collection('watch_later')
        .doc(video.vid);
    return userDataRef.set(video.toJson());
  }
}
