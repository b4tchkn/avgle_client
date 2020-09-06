import 'package:avgleclient/res/app_colors.dart';
import 'package:avgleclient/res/strings.dart';
import 'package:avgleclient/ui/history/history_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HistorySearchBar extends StatelessWidget {
  const HistorySearchBar({@required HistoryViewModel viewModel})
      : _viewModel = viewModel;

  final HistoryViewModel _viewModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      color: AppColors.darkGrey,
      child: Row(
        children: [
          Container(
            padding:
                const EdgeInsets.only(left: 16, top: 8, right: 16, bottom: 8),
            child: const Icon(
              Icons.search,
              color: AppColors.lightGrey,
              size: 24,
            ),
          ),
          Expanded(
            child: TextField(
              controller: _viewModel.searchTextEditingController,
              onChanged: (String _) {
                _viewModel.searchHistoryVideos();
              },
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: Strings.historySearchHint,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
