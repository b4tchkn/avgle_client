import 'package:avgleclient/res/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlaylistTopItem extends StatelessWidget {
  const PlaylistTopItem(
      {@required String playlistName, @required String userName})
      : _playlistName = playlistName,
        _userName = userName;

  final String _playlistName;
  final String _userName;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      color: AppColors.darkGrey.withOpacity(0.5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(top: 16, left: 16),
            child: Text(
              _playlistName,
              style: const TextStyle(fontSize: 24),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 16, top: 8),
            child: Text(
              _userName,
              style: const TextStyle(fontSize: 14),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 16, top: 16),
            child: IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                // TODO 編集画面へ遷移
                debugPrint('編集ボタンタップされた');
              },
            ),
          ),
        ],
      ),
    );
  }
}
