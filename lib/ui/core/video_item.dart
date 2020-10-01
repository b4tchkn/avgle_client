import 'package:avgleclient/data/model/video_res.dart';
import 'package:avgleclient/data/provider/firebase_auth_provider.dart';
import 'package:avgleclient/res/app_colors.dart';
import 'package:avgleclient/ui/core/video_more_modal_bottom_sheet.dart';
import 'package:avgleclient/ui/core/video_web_view.dart';
import 'package:avgleclient/util/converters.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';

class VideoItem extends HookWidget {
  const VideoItem(
      {@required dynamic viewModel,
      @required Video video,
      @required List<String> playlists,
      @required BuildContext buildContext})
      : _viewModel = viewModel,
        _video = video,
        _playlists = playlists,
        _buildContext = buildContext;

  final dynamic _viewModel;
  final Video _video;
  final List<String> _playlists;
  final BuildContext _buildContext;

  @override
  Widget build(BuildContext context) {
    final _viewCount = Converters.toViewCountFormatted(_video.viewnumber);
    final _addedAt = Converters.toAddedAtFormatted(_video.addtime);
    final user = useProvider(firebaseAuthProvider);

    return InkWell(
      onTap: () => {
        Navigator.push<Widget>(
            context,
            MaterialPageRoute(
                builder: (context) => VideoWebView(
                      videoUrl: _video.videoUrl,
                      videoTitle: _video.title,
                    ))),
        _viewModel.addVideoInHistory(_video)
      },
      child: Container(
        child: Column(
          children: [
            Stack(
              children: [
                Ink.image(
                  image: NetworkImage(_video.previewUrl),
                  fit: BoxFit.cover,
                  height: 220,
                ),
                Positioned(
                  bottom: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    color: AppColors.darkGrey,
                    child: Text(
                      Converters.toVideoDurationFormatted(_video.duration),
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                ),
                if (_video.hd)
                  Positioned(
                    top: 8,
                    right: 8,
                    child: SizedBox(
                      height: 60,
                      width: 60,
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
                            _video.title,
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
                              _video.keyword,
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
                  if (user.currentUser != null)
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
                          _showModalBottomSheet(_buildContext);
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

  void _showModalBottomSheet(BuildContext buildContext) {
    showModalBottomSheet<String>(
      context: buildContext,
      builder: (BuildContext _) {
        return VideoMoreModalBottomSheet(
          viewModel: _viewModel,
          video: _video,
          playlists: _playlists,
          buildContext: buildContext,
        );
      },
    );
  }
}
