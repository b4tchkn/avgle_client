import 'package:avgleclient/data/model/video_res.dart';
import 'package:avgleclient/res/app_colors.dart';
import 'package:avgleclient/ui/core/video_more_modal_bottom_sheet.dart';
import 'package:avgleclient/ui/core/video_web_view.dart';
import 'package:avgleclient/ui/library/library_view_model.dart';
import 'package:avgleclient/util/converters.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RecentlyWatchedItem extends StatelessWidget {
  const RecentlyWatchedItem(
      {@required LibraryViewModel viewModel,
      @required Video video,
      @required List<String> playlists,
      @required BuildContext buildContext})
      : _viewModel = viewModel,
        _video = video,
        _playlists = playlists,
        _buildContext = buildContext;

  final LibraryViewModel _viewModel;
  final Video _video;
  final List<String> _playlists;
  final BuildContext _buildContext;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: InkWell(
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
        child: Container(
          width: 160,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Ink.image(
                    image: NetworkImage(_video.previewUrl),
                    fit: BoxFit.cover,
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
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      _video.title,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: const TextStyle(fontSize: 14),
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
              Text(
                _video.keyword,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style:
                    const TextStyle(fontSize: 12, color: AppColors.lightGrey),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _showModalBottomSheet() {
    showModalBottomSheet(
      context: _buildContext,
      builder: (BuildContext _) {
        return VideoMoreModalBottomSheet(
          viewModel: _viewModel,
          video: _video,
          playlists: _playlists,
          buildContext: _buildContext,
        );
      },
    );
  }
}
