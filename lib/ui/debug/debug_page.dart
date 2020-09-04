import 'package:avgleclient/res/app_colors.dart';
import 'package:avgleclient/res/strings.dart';
import 'package:avgleclient/ui/debug/debug_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DebugPage extends HookWidget {
  final auth = FirebaseAuth.instance;
  final googleSignIn = GoogleSignIn();

  @override
  Widget build(BuildContext context) {
    final viewModel = useProvider(debugViewModelNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.debugPageTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: SingleChildScrollView(
          child: Column(
            children: [
              FlatButton(
                child: const Text(Strings.profileSignInWithGoogle),
                color: AppColors.lightGrey,
                onPressed: () {
                  viewModel.signIn();
                },
              ),
              FlatButton(
                child: const Text(Strings.profileSignOut),
                color: AppColors.lightGrey,
                onPressed: () {
                  viewModel.signOut();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
