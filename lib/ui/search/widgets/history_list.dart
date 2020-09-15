import 'package:avgleclient/ui/search/search_view_model.dart';
import 'package:avgleclient/ui/search/widgets/delete_search_history_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class HistoryList extends StatelessWidget {
  const HistoryList(
      {@required SearchViewModel viewModel,
      @required Future<Database> database})
      : _viewModel = viewModel,
        _database = database;

  final SearchViewModel _viewModel;
  final Future<Database> _database;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: _viewModel.histories.length,
        itemBuilder: (BuildContext _, int index) {
          return ListTile(
            leading: const Icon(Icons.history),
            title: Text(_viewModel.histories[index].keyword),
            onTap: () {
              FocusScope.of(context).unfocus();
              _viewModel.searchVideos(_viewModel.histories[index].keyword);
            },
            onLongPress: () {
              showDialog(
                  context: context,
                  builder: (BuildContext dialogContext) {
                    return DeleteSearchHistoryDialog(
                      viewModel: _viewModel,
                      keyword: _viewModel.histories[index].keyword,
                      database: _database,
                      dialogContext: dialogContext,
                    );
                  });
            },
          );
        });
  }
}
