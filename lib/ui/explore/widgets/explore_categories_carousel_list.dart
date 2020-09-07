import 'package:avgleclient/res/app_colors.dart';
import 'package:avgleclient/ui/explore/explore_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExploreCategoriesCarouselList extends StatelessWidget {
  const ExploreCategoriesCarouselList({@required ExploreViewModel viewModel})
      : _viewModel = viewModel;

  final ExploreViewModel _viewModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 240,
      child: GridView.count(
        padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
        scrollDirection: Axis.horizontal,
        childAspectRatio: 0.5,
        crossAxisCount: 2,
        children: List.generate(_viewModel.categories.length, (index) {
          return Card(
            color: AppColors.accentBlue,
            margin: const EdgeInsets.all(8),
            child: Column(
              children: [
                Text(_viewModel.categories[index].shortname),
              ],
            ),
          );
        }),
      ),
    );
  }
}
