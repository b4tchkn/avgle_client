import 'package:avgleclient/res/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showSimpleSnackBar(BuildContext context, String message) {
  final snackBar = SnackBar(
    content: Text(
      message,
      style: const TextStyle(color: AppColors.pureWhite),
    ),
    backgroundColor: AppColors.darkGrey,
  );
  Scaffold.of(context).showSnackBar(snackBar);
}
