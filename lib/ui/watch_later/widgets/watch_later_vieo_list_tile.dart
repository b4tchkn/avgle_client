import 'package:avgleclient/data/model/video_res.dart';
import 'package:avgleclient/res/app_colors.dart';
import 'package:avgleclient/ui/core/video_web_view.dart';
import 'package:avgleclient/ui/watch_later/watch_later_view_model.dart';
import 'package:avgleclient/ui/watch_later/widgets/watch_later_video_more_modal_bottom_sheet.dart';
import 'package:avgleclient/util/converters.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WatchLaterVideoListTile extends StatelessWidget {
  const WatchLaterVideoListTile(
      {@required WatchLaterViewModel viewModel,
      @required Video video,
      @required List<String> playlists,
      @required BuildContext buildContext})
      : _viewModel = viewModel,
        _video = video,
        _playlists = playlists,
        _buildContext = buildContext;

  final WatchLaterViewModel _viewModel;
  final Video _video;
  final List<String> _playlists;
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
                      videoTitle: _video.title,
                    )));
        _viewModel.addVideoInHistory(_video);
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 8, left: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image(
                  image: NetworkImage(_video.previewUrl),
                  height: 80,
                ),
                Positioned(
                  bottom: 4,
                  right: 4,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    color: AppColors.darkGrey,
                    child: Text(
                      Converters.toVideoDurationFormatted(_video.duration),
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                )
              ],
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
          return WatchLaterVideoMoreModalBottomSheet(
            viewModel: _viewModel,
            video: _video,
            playlists: _playlists,
            buildContext: _buildContext,
          );
        });
  }
}
