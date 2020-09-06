import 'package:avgleclient/data/model/video_res.dart';
import 'package:avgleclient/res/app_colors.dart';
import 'package:avgleclient/ui/watch_later/watch_later_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WatchLaterVideoListTile extends StatelessWidget {
  const WatchLaterVideoListTile(
      {@required WatchLaterViewModel viewModel, @required Video video})
      : _viewModel = viewModel,
        _video = video;

  final WatchLaterViewModel _viewModel;
  final Video _video;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // TODO WebViewに遷移させる
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 8, left: 16, right: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image(
              image: NetworkImage(_video.previewUrl),
              height: 80,
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
              height: 20,
              width: 20,
              child: IconButton(
                padding: const EdgeInsets.all(4),
                icon: const Icon(
                  Icons.more_vert,
                  size: 20,
                ),
                onPressed: () {
                  // TODO ModaiBottomSheet出す処理
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
