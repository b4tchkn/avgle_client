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
        .collection('history')
        .orderBy('at_watched', descending: true);
    final res = await userDataRef.get();
    final newVideos = <Video>[];
    // ignore: avoid_function_literals_in_foreach_calls
    res.docs.forEach((video) {
      newVideos.add(Video.fromJson(video.data()));
    });
    return newVideos;
  }

  Future<List<Video>> fetchPlaylistVideos(String playlistName) async {
    final userDataRef = _store
        .collection(_auth.currentUser.uid)
        .doc('data')
        .collection('playlist')
        .doc(playlistName)
        .collection('video');
    final res = await userDataRef.get();
    final newVideos = <Video>[];
    // ignore: avoid_function_literals_in_foreach_calls
    res.docs.forEach((video) {
      newVideos.add(Video.fromJson(video.data()));
    });
    return newVideos;
  }

  Future<List<String>> fetchPlaylists() async {
    final userDataRef = _store
        .collection(_auth.currentUser.uid)
        .doc('data')
        .collection('playlist');
    final res = await userDataRef.get();

    final playlists = <String>[];
    // ignore: avoid_function_literals_in_foreach_calls
    res.docs.forEach((playlist) {
      playlists.add(playlist.id);
    });
    return playlists;
  }

  Future<void> addVideoInPlaylist(String playlistName, Video video) {
    final userDataRef = _store
        .collection(_auth.currentUser.uid)
        .doc('data')
        .collection('playlist')
        .doc(playlistName)
        .collection('video')
        .doc(video.vid);
    return userDataRef.set(video.toJson());
  }

  Future<void> createPlaylist(String playlistName) {
    final userDataRef = _store
        .collection(_auth.currentUser.uid)
        .doc('data')
        .collection('playlist')
        .doc(playlistName);

    // なにかしらFieldに入れないとプレイリストのdocumentを配列で取れないので
    // プレイリスト作成時に挿入する用
    final initialField = {'key': 'value'};
    return userDataRef.set(initialField);
  }

  Future<void> deleteVideoInHistory(String vid) {
    final userDataRef = _store
        .collection(_auth.currentUser.uid)
        .doc('data')
        .collection('history')
        .doc(vid);
    return userDataRef.delete();
  }

  Future<void> deleteVideoInWatchLater(String vid) {
    final userDataRef = _store
        .collection(_auth.currentUser.uid)
        .doc('data')
        .collection('watch_later')
        .doc(vid);
    return userDataRef.delete();
  }

  Future<void> deleteVideoInPlaylist(String vid, String playlistName) {
    final userDataRef = _store
        .collection(_auth.currentUser.uid)
        .doc('data')
        .collection('playlist')
        .doc(playlistName)
        .collection('video')
        .doc(vid);
    return userDataRef.delete();
  }
}
