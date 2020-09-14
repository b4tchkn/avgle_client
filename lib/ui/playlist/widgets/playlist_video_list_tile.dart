import 'package:avgleclient/data/model/video_res.dart';
import 'package:avgleclient/res/app_colors.dart';
import 'package:avgleclient/ui/core/video_web_view.dart';
import 'package:avgleclient/ui/playlist/playlist_view_model.dart';
import 'package:avgleclient/ui/playlist/widgets/playlist_video_more_modal_bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlaylistVideoListTile extends StatelessWidget {
  const PlaylistVideoListTile(
      {@required PlaylistViewModel viewModel,
      @required Video video,
      @required String playlistName,
      @required BuildContext buildContext})
      : _viewModel = viewModel,
        _video = video,
        _playlistName = playlistName,
        _buildContext = buildContext;

  final PlaylistViewModel _viewModel;
  final Video _video;
  final String _playlistName;
  final BuildContext _buildContext;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => VideoWebView(
                      videoUrl: _video.videoUrl,
                    )));
        _viewModel.addVideoInHistory(_video);
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 8, left: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image(
              image: NetworkImage(_video.previewUrl),
              height: 100,
            ),
            Container(
              width: 16,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _video.title,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 14),
                  ),
                  Text(
                    _video.keyword,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 12, color: AppColors.lightGrey),
                  )
                ],
              ),
            ),
            Container(
              child: IconButton(
                icon: const Icon(
                  Icons.more_vert,
                  size: 20,
                ),
                onPressed: () {
                  _showModalBottomSheet();
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  void _showModalBottomSheet() {
    showModalBottomSheet(
        context: _buildContext,
        builder: (BuildContext _) {
          return PlaylistVideoMoreModalBottomSheet(
            viewModel: _viewModel,
            video: _video,
            playlistName: _playlistName,
            buildContext: _buildContext,
          );
        });
  }
}
