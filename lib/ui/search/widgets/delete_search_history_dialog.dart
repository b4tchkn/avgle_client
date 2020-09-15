import 'package:avgleclient/res/strings.dart';
import 'package:avgleclient/ui/search/search_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class DeleteSearchHistoryDialog extends StatelessWidget {
  const DeleteSearchHistoryDialog({
    @required SearchViewModel viewModel,
    @required String keyword,
    @required Future<Database> database,
    @required BuildContext dialogContext,
  })  : _viewModel = viewModel,
        _keyword = keyword,
        _database = database,
        _dialogContext = dialogContext;

  final SearchViewModel _viewModel;
  final String _keyword;
  final Future<Database> _database;
  final BuildContext _dialogContext;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(_keyword),
      content: const Text(Strings.searchDeleteSearchHistoryDialogTitle),
      actions: [
        FlatButton(
          child: const Text(Strings.searchDeleteSearchHistoryDialogCancel),
          onPressed: () {
            Navigator.pop(_dialogContext);
          },
        ),
        FlatButton(
          child: const Text(Strings.searchDeleteSearchHistoryDialogDelete),
          onPressed: () {
            Navigator.pop(_dialogContext);
            _viewModel.deleteSearchHistories(_database, _keyword.hashCode);
          },
        )
      ],
    );
  }
}
