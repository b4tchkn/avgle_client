import 'package:avgleclient/data/model/category_res.dart';
import 'package:avgleclient/res/app_colors.dart';
import 'package:avgleclient/res/strings.dart';
import 'package:avgleclient/ui/category/category_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExploreCategoryItem extends StatelessWidget {
  const ExploreCategoryItem({@required Category category})
      : _category = category;

  final Category _category;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: FractionalOffset.topCenter,
          end: FractionalOffset.bottomCenter,
          colors: [
            AppColors.pureWhite.withOpacity(0),
            AppColors.darkGrey.withOpacity(1),
          ],
        ),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => CategoryPage(
                        category: _category,
                      )));
        },
        child: Stack(
          children: [
            Ink.image(
              image: NetworkImage(_category.coverUrl),
              fit: BoxFit.cover,
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _category.name,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      Strings.exploreCategoryVideoCount(_category.totalVideos),
                      style: const TextStyle(fontSize: 14),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
