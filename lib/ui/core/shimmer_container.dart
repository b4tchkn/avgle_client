import 'package:avgleclient/res/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerContainer extends StatelessWidget {
  const ShimmerContainer({@required double width, @required double height})
      : _width = width,
        _height = height;

  final double _width;
  final double _height;
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.lightGrey,
      highlightColor: AppColors.pureWhite,
      enabled: true,
      child: Container(
        color: AppColors.pureWhite,
        width: _width,
        height: _height,
      ),
    );
  }
}
