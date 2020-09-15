import 'package:avgleclient/res/app_colors.dart';
import 'package:avgleclient/res/strings.dart';
import 'package:avgleclient/ui/search/search_view_model.dart';
import 'package:avgleclient/ui/search/widgets/history_list.dart';
import 'package:avgleclient/ui/search/widgets/search_bar.dart';
import 'package:avgleclient/ui/search/widgets/search_result_list.dart';
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
          title: SearchBar(
            viewModel: viewModel,
            database: _database,
          ),
        ),
        body: Builder(
          builder: (BuildContext buildContext) {
            return !viewModel.isSearched
                ? HistoryList(viewModel: viewModel)
                : !viewModel.isLoading
                    ? SearchResultList(
                        viewModel: viewModel,
                        buildContext: buildContext,
                      )
                    : const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
