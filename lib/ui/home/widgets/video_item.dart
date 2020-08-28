import 'package:avgleclient/data/model/video_res.dart';
import 'package:avgleclient/ui/core/VideoWebView.dart';
import 'package:avgleclient/ui/home/home_view_model.dart';
import 'package:avgleclient/ui/home/widgets/VideoMoreModalBottomSheet.dart';
import 'package:avgleclient/util/converters.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class VideoItem extends StatelessWidget {
  const VideoItem(
      {@required this.viewModel, @required this.video, @required this.context});

  final HomeViewModel viewModel;
  final Video video;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    final _viewCount = Converters.toViewCountFormatted(video.viewnumber);
    final _addedAt = Converters.toAddedAtFormatted(video.addtime);

    return InkWell(
      onTap: () => {
        Navigator.push<Widget>(
            context,
            MaterialPageRoute(
                builder: (context) => VideoWebView(video.videoUrl)))
      },
      child: Container(
        child: Column(
          children: [
            Stack(
              children: [
                Ink.image(
                  image: NetworkImage(video.previewUrl),
                  fit: BoxFit.cover,
                  height: 220,
                ),
                Positioned(
                  bottom: 8,
                  right: 8,
                  child: Text(video.duration.toString()),
                ),
                if (video.hd)
                  Positioned(
                    top: 8,
                    right: 8,
                    child: SizedBox(
                      height: 80,
                      width: 80,
                      child: Lottie.asset('assets/lotties/video_hd_icon.json'),
                    ),
                  ),
              ],
            ),
            Container(
              padding: const EdgeInsets.only(
                top: 8,
                left: 16,
                right: 16,
                bottom: 24,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            video.title,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: const TextStyle(
                              fontSize: 14,
                              height: 1.1,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 4,
                              bottom: 4,
                            ),
                            child: Text(
                              video.keyword,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                height: 1.1,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          Text('$_viewCount・$_addedAt'),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 40,
                    child: IconButton(
                      padding: const EdgeInsets.all(4),
                      icon: const Icon(
                        Icons.more_vert,
                        size: 20,
                      ),
                      onPressed: () {
                        _showModalBottomSheet(context, video);
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _showModalBottomSheet(BuildContext context, Video video) {
    showModalBottomSheet<String>(
      context: context,
      builder: (BuildContext bc) {
        return VideoMoreModalBottomSheet(
          video: video,
        );
      },
    );
  }
}
