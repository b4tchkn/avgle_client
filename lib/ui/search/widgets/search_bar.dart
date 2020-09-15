import 'package:avgleclient/res/app_colors.dart';
import 'package:avgleclient/res/strings.dart';
import 'package:avgleclient/ui/search/search_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class SearchBar extends StatelessWidget {
  const SearchBar(
      {@required SearchViewModel viewModel,
      @required Future<Database> database})
      : _viewModel = viewModel,
        _database = database;

  final SearchViewModel _viewModel;
  final Future<Database> _database;
  @override
  Widget build(BuildContext context) {
    return Container(
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
            controller: _viewModel.searchTextEditingController,
            onChanged: (String text) {
              _viewModel.changeTextFieldState(text == '');
            },
            textInputAction: TextInputAction.search,
            onSubmitted: (String searchWord) {
              if (_viewModel.searchTextEditingController.text != '') {
                _viewModel.searchVideos(searchWord);
                _viewModel.addSearchHistory(_database, searchWord);
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
    );
  }
}
