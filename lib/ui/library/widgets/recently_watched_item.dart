import 'package:avgleclient/data/model/video_res.dart';
import 'package:avgleclient/res/app_colors.dart';
import 'package:avgleclient/ui/core/VideoWebView.dart';
import 'package:avgleclient/ui/library/library_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RecentlyWatchedItem extends StatelessWidget {
  const RecentlyWatchedItem(
      {@required LibraryViewModel viewModel, @required Video video})
      : _viewModel = viewModel,
        _video = video;

  final LibraryViewModel _viewModel;
  final Video _video;
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
                      )));
          _viewModel.addVideoInHistory(_video);
        },
        child: Container(
          width: 160,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Ink.image(
                image: NetworkImage(_video.previewUrl),
                fit: BoxFit.cover,
                height: 80,
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
                      onPressed: () {},
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
}
