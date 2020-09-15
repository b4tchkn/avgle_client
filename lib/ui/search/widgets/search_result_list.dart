import 'package:avgleclient/res/strings.dart';
import 'package:avgleclient/ui/search/search_view_model.dart';
import 'package:avgleclient/ui/search/widgets/searched_video_list_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:lottie/lottie.dart';

class SearchResultList extends StatelessWidget {
  const SearchResultList(
      {@required SearchViewModel viewModel,
      @required BuildContext buildContext})
      : _viewModel = viewModel,
        _buildContext = buildContext;

  final SearchViewModel _viewModel;
  final BuildContext _buildContext;
  @override
  Widget build(BuildContext context) {
    return _viewModel.searchedVideos.isNotEmpty
        ? ListView.builder(
            itemCount: _viewModel.searchedVideos.length,
            itemBuilder: (BuildContext _, int index) {
              return SearchedVideoListTile(
                viewModel: _viewModel,
                video: _viewModel.searchedVideos[index],
                playlists: _viewModel.playlists,
                buildContext: _buildContext,
              );
            })
        : Center(
            child: Container(
              width: 240,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.network(
                      'https://assets3.lottiefiles.com/packages/lf20_1lHBrH.json'),
                  Text(
                    Strings.searchVideoNoResults(
                        _viewModel.searchTextEditingController.text),
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          );
  }
}
