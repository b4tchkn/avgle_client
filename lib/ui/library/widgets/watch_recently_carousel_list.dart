import 'package:avgleclient/data/model/video_res.dart';
import 'package:avgleclient/data/provider/firebase_firestore_recently_watched_stream_provider.dart';
import 'package:avgleclient/ui/library/library_view_model.dart';
import 'package:avgleclient/ui/library/widgets/recently_watched_item.dart';
import 'package:avgleclient/ui/library/widgets/recently_watched_place_holder_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class WatchRecentlyCarouselList extends HookWidget {
  const WatchRecentlyCarouselList(
      {@required LibraryViewModel viewModel,
      @required List<String> playlists,
      @required BuildContext buildContext})
      : _viewModel = viewModel,
        _playlists = playlists,
        _buildContext = buildContext;

  final LibraryViewModel _viewModel;
  final List<String> _playlists;
  final BuildContext _buildContext;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: useProvider(firebaseFirestoreRecentlyWatchedStreamProvider),
        builder: (_, snapshot) {
          return Container(
            height: 160,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: !snapshot.hasData ? 5 : snapshot.data.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  return !snapshot.hasData
                      ? RecentlyWatchedPlaceHolderItem()
                      : RecentlyWatchedItem(
                          viewModel: _viewModel,
                          video:
                              Video.fromJson(snapshot.data.docs[index].data()),
                          playlists: _playlists,
                          buildContext: _buildContext,
                        );
                }),
          );
        });
  }
}
