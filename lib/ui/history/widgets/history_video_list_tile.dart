import 'package:avgleclient/data/model/video_res.dart';
import 'package:avgleclient/res/app_colors.dart';
import 'package:avgleclient/res/strings.dart';
import 'package:avgleclient/ui/core/video_web_view.dart';
import 'package:avgleclient/ui/history/history_view_model.dart';
import 'package:avgleclient/ui/history/widgets/history_video_more_modal_bottom_sheet.dart';
import 'package:avgleclient/util/converters.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HistoryVideoListTile extends StatelessWidget {
  const HistoryVideoListTile(
      {@required HistoryViewModel viewModel,
      @required Video video,
      @required BuildContext buildContext})
      : _viewModel = viewModel,
        _video = video,
        _buildContext = buildContext;

  final HistoryViewModel _viewModel;
  final Video _video;
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
              height: 90,
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
                  ),
                  Text(
                    Strings.historyVideoViewCount(
                      Converters.toViewCountFormatted(_video.viewnumber),
                    ),
                    style: const TextStyle(
                        fontSize: 12, color: AppColors.lightGrey),
                  ),
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
          return HistoryVideoMoreModalBottomSheet(
            viewModel: _viewModel,
            video: _video,
            buildContext: _buildContext,
          );
        });
  }
}