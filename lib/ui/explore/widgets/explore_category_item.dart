import 'package:avgleclient/data/model/category_res.dart';
import 'package:avgleclient/res/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExploreCategoryItem extends StatelessWidget {
  const ExploreCategoryItem({@required Category category})
      : _category = category;

  final Category _category;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(4))),
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(4)),
        onTap: () {},
        child: Stack(
          children: [
            Text(_category.name),
          ],
        ),
      ),
    );
  }
}
