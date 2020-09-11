import 'package:avgleclient/ui/explore/explore_view_model.dart';
import 'package:avgleclient/ui/explore/widgets/explore_category_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExploreCategoriesCarouselList extends StatelessWidget {
  const ExploreCategoriesCarouselList({@required ExploreViewModel viewModel})
      : _viewModel = viewModel;

  final ExploreViewModel _viewModel;
  @override
  Widget build(BuildContext context) {
    const double listHeight = 160;
    const double itemWidth = 400;
    return Container(
      margin: const EdgeInsets.only(top: 4, left: 4, right: 4),
      height: listHeight,
      child: GridView.count(
        scrollDirection: Axis.horizontal,
        childAspectRatio: listHeight / itemWidth,
        crossAxisCount: 2,
        children: List.generate(_viewModel.categories.length, (index) {
          return ExploreCategoryItem(category: _viewModel.categories[index]);
        }),
      ),
    );
  }
}
