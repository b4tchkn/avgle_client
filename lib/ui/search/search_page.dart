import 'package:avgleclient/res/app_colors.dart';
import 'package:avgleclient/res/strings.dart';
import 'package:avgleclient/ui/search/search_view_model.dart';
import 'package:avgleclient/ui/search/widgets/searched_video_list_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sqflite/sqflite.dart';

class SearchPage extends HookWidget {
  const SearchPage({@required Future<Database> database})
      : _database = database;

  final Future<Database> _database;
  @override
  Widget build(BuildContext context) {
    final viewModel = useProvider(searchViewModelNotifierProvider);
    final getSearchHistories =
        useMemoized(() => viewModel.getSearchHistories(_database));
    final fetchPlaylists = useMemoized(() => viewModel.fetchPlaylists());
    useFuture(getSearchHistories);
    useFuture(fetchPlaylists);
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context);
        viewModel.onWillPop();
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Container(
            height: 40,
            padding: const EdgeInsets.only(left: 8),
            decoration: const BoxDecoration(
              color: AppColors.darkGrey,
              borderRadius: BorderRadius.all(
                Radius.circular(4),
              ),
            ),
            child: Stack(
              children: [
                TextField(
                  controller: viewModel.searchTextEditingController,
                  onChanged: (String text) {
                    viewModel.changeTextFieldState(text == '');
                  },
                  textInputAction: TextInputAction.search,
                  onSubmitted: (String searchWord) {
                    if (viewModel.searchTextEditingController.text != '') {
                      viewModel.searchVideos(searchWord);
                      viewModel.addSearchHistory(_database, searchWord);
                    }
                  },
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: Strings.searchHint,
                    hintMaxLines: 1,
                    // suffixIcon: !viewModel.isTextFieldEmpty
                    //     ? IconButton(
                    //         icon: const Icon(Icons.clear),
                    //         onPressed: () {
                    //           viewModel.onTapTextFieldClear();
                    //         },
                    //       )
                    //     : Container(),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Builder(
          builder: (BuildContext buildContext) {
            return !viewModel.isSearched
                ? ListView.builder(
                    itemCount: viewModel.histories.length,
                    itemBuilder: (BuildContext _, int index) {
                      return ListTile(
                        leading: const Icon(Icons.history),
                        title: Text(viewModel.histories[index].keyword),
                        onTap: () {
                          FocusScope.of(context).unfocus();
                          viewModel
                              .searchVideos(viewModel.histories[index].keyword);
                        },
                      );
                    })
                : ListView.builder(
                    itemCount: viewModel.searchedVideos.length,
                    itemBuilder: (BuildContext _, int index) {
                      return SearchedVideoListTile(
                        viewModel: viewModel,
                        video: viewModel.searchedVideos[index],
                        playlists: viewModel.playlists,
                        buildContext: buildContext,
                      );
                    });
          },
        ),
      ),
    );
  }
}
