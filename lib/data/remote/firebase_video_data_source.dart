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

  Future<void> addVideoInHistory(Video video) {
    final userDataRef = _store
        .collection(_auth.currentUser.uid)
        .doc('data')
        .collection('history')
        .doc(video.vid);
    return userDataRef.set(video.toJson());
  }

  Future<List<Video>> fetchRecentlyWatchedVideos() async {
    final userDataRef = _store
        .collection(_auth.currentUser.uid)
        .doc('data')
        .collection('history')
        .limit(10)
        .orderBy('at_watched', descending: true);
    final res = await userDataRef.get();
    final newVideos = <Video>[];
    // ignore: avoid_function_literals_in_foreach_calls
    res.docs.forEach((video) {
      newVideos.add(Video.fromJson(video.data()));
    });
    return newVideos;
  }

  Future<List<Video>> fetchWatchLaterVideos() async {
    final userDataRef = _store
        .collection(_auth.currentUser.uid)
        .doc('data')
        .collection('watch_later');
    final res = await userDataRef.get();
    final newVideos = <Video>[];
    // ignore: avoid_function_literals_in_foreach_calls
    res.docs.forEach((video) {
      newVideos.add(Video.fromJson(video.data()));
    });
    return newVideos;
  }

  Future<List<Video>> fetchHistoryVideos() async {
    final userDataRef = _store
        .collection(_auth.currentUser.uid)
        .doc('data')
        .collection('history');
    final res = await userDataRef.get();
    final newVideos = <Video>[];
    // ignore: avoid_function_literals_in_foreach_calls
    res.docs.forEach((video) {
      newVideos.add(Video.fromJson(video.data()));
    });
    return newVideos;
  }
}
