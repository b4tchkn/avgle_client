import 'package:avgleclient/res/app_colors.dart';
import 'package:avgleclient/res/strings.dart';
import 'package:avgleclient/ui/profile/profile_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileTopSignedIn extends StatelessWidget {
  const ProfileTopSignedIn({@required ProfileViewModel viewModel})
      : _viewModel = viewModel;

  final ProfileViewModel _viewModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Material(
            elevation: 4.0,
            shape: const CircleBorder(),
            clipBehavior: Clip.hardEdge,
            child: Image(
              image: NetworkImage(_viewModel.user.photoURL),
              fit: BoxFit.cover,
              width: 60,
              height: 60,
            ),
          ),
          Container(
            width: 16,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(_viewModel.user.displayName),
              Text(_viewModel.user.email),
              Container(height: 8),
              InkWell(
                child: const Text(
                  Strings.profileSignOut,
                  style: TextStyle(
                    color: AppColors.accentBlue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  _viewModel.signOut();
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
