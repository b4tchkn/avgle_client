import 'package:avgleclient/ui/search/search_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HistoryList extends StatelessWidget {
  const HistoryList({@required SearchViewModel viewModel})
      : _viewModel = viewModel;

  final SearchViewModel _viewModel;
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
          );
        });
  }
}
