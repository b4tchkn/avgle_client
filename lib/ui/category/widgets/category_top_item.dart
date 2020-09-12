import 'package:avgleclient/data/model/category_res.dart';
import 'package:avgleclient/res/app_colors.dart';
import 'package:avgleclient/res/strings.dart';
import 'package:flutter/cupertino.dart';

class CategoryTopItem extends StatelessWidget {
  const CategoryTopItem({@required Category category, @required int videoCount})
      : _category = category,
        _videoCount = videoCount;

  final Category _category;
  final int _videoCount;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Hero(
          // ignore: unnecessary_string_interpolations
          tag: '${_category.slug}',
          child: Container(
            height: 160,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(_category.coverUrl),
              ),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(top: 4, left: 16),
          child: Text(
            _category.name,
            style: const TextStyle(
              fontSize: 24,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(bottom: 8, left: 16),
          child: Text(
            Strings.categoryVideoCount(_videoCount),
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.lightGrey,
            ),
          ),
        )
      ],
    );
  }
}
