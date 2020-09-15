import 'package:avgleclient/res/app_colors.dart';
import 'package:avgleclient/res/strings.dart';
import 'package:avgleclient/ui/edit_playlist/edit_playlist_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlaylistTopItem extends StatelessWidget {
  const PlaylistTopItem(
      {@required String playlistName,
      @required String userName,
      @required int videoCount})
      : _playlistName = playlistName,
        _userName = userName,
        _videoCount = videoCount;

  final String _playlistName;
  final String _userName;
  final int _videoCount;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 160,
          width: MediaQuery.of(context).size.width,
          color: AppColors.darkGrey.withOpacity(0.5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
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
              // Container(
              //   padding: const EdgeInsets.only(left: 16, top: 16),
              //   child: IconButton(
              //     icon: const Icon(Icons.edit),
              //     onPressed: () {
              //       Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //               builder: (_) => EditPlaylistPage(
              //                     playlistName: _playlistName,
              //                   )));
              //     },
              //   ),
              // ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 16, top: 8, bottom: 8),
          child: Text(
            Strings.playlistVideoCount(_videoCount),
            style: const TextStyle(fontSize: 14),
          ),
        ),
      ],
    );
  }
}
