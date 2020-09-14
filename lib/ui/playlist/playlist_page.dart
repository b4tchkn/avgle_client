import 'package:avgleclient/res/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class PlaylistPage extends HookWidget {
  const PlaylistPage({@required String playlistName})
      : _playlistName = playlistName;

  final String _playlistName;
  @override
  Widget build(BuildContext context) {
    final items = <Widget>[
      Container(
        height: 200,
        color: AppColors.accentBlue,
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text(_playlistName),
      ),
      body: Builder(
        builder: (BuildContext buildContext) {
          return RefreshIndicator(
            onRefresh: () {
              // TODO プレイリスト動画取得
            },
            child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (_, index) {
                  return items[index];
                }),
          );
        },
      ),
    );
  }
}
