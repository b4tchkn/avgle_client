import 'package:avgleclient/res/app_colors.dart';
import 'package:avgleclient/res/strings.dart';
import 'package:avgleclient/ui/profile/profile_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ProfileTopSignedOut extends StatelessWidget {
  const ProfileTopSignedOut({@required ProfileViewModel viewModel})
      : _viewModel = viewModel;

  final ProfileViewModel _viewModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 8),
                child: Text(
                  Strings.profilePleaseSignIn,
                  style: TextStyle(fontSize: 16),
                ),
              ),
              FlatButton(
                child: const Text('Googleでログイン'),
                color: AppColors.lightGrey,
                onPressed: () {
                  _viewModel.signIn();
                },
              )
            ],
          ),
          Lottie.asset('assets/lotties/profile_please_sign_in.json',
              width: 140),
        ],
      ),
    );
  }
}
