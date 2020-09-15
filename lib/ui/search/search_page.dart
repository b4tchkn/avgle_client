import 'package:avgleclient/res/app_colors.dart';
import 'package:avgleclient/res/strings.dart';
import 'package:avgleclient/ui/search/search_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SearchPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = useProvider(searchViewModelNotifierProvider);
    final init = useMemoized(() => viewModel.init());
    final getSearchHistories =
        useMemoized(() => viewModel.getSearchHistories());
    useFuture(init);
    useFuture(getSearchHistories);
    return Scaffold(
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
          child: TextField(
            textInputAction: TextInputAction.search,
            onSubmitted: (String searchWord) {
              // TODO 実際に検索する処理
              viewModel.addSearchHistory(searchWord);
            },
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: Strings.searchHint,
              hintMaxLines: 1,
            ),
          ),
        ),
      ),
      body: Builder(
        builder: (BuildContext buildContext) {
          return ListView.builder(
              itemCount: viewModel.histories.length,
              itemBuilder: (BuildContext _, int index) {
                return ListTile(
                  leading: const Icon(Icons.history),
                  title: Text(viewModel.histories[index].keyword),
                  onTap: () {
                    // TODO このキーワードで検索
                  },
                );
              });
        },
      ),
    );
  }
}