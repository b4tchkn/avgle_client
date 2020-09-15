import 'package:avgleclient/res/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class SearchPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          color: AppColors.accentBlue,
        ),
      ),
      body: Builder(
        builder: (BuildContext buildContext) {
          return ListView.builder(
              itemCount: 10,
              itemBuilder: (BuildContext _, int index) {
                return ListTile(
                  leading: const Icon(Icons.history),
                  title: Text('履歴タイトル'),
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
