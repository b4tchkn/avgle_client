import 'package:avgleclient/res/app_colors.dart';
import 'package:avgleclient/res/strings.dart';
import 'package:avgleclient/ui/library/library_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GoogleSignInButton extends StatelessWidget {
  const GoogleSignInButton({@required LibraryViewModel viewModel})
      : _viewModel = viewModel;

  final LibraryViewModel _viewModel;
  @override
  Widget build(BuildContext context) {
    return OutlineButton(
      splashColor: AppColors.lightGrey,
      onPressed: () => _viewModel.signIn(),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: const BorderSide(color: AppColors.lightGrey),
      child: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            const Image(
                image: AssetImage('assets/images/google_icon.png'), height: 35),
            const Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                Strings.librarySignInWithGoogle,
                style: TextStyle(fontSize: 20, color: AppColors.lightGrey),
              ),
            )
          ],
        ),
      ),
    );
  }
}
