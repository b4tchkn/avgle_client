import 'package:avgleclient/res/strings.dart';
import 'package:avgleclient/ui/core/google_sign_in_button.dart';
import 'package:avgleclient/ui/library/library_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';

class LibraryPageSignedOut extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = useProvider(libraryViewModelNotifierProvider);
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 300,
            child: Lottie.asset('assets/lotties/please_sign_in.json'),
          ),
          const Padding(
            padding: EdgeInsets.all(24.0),
            child: Text(
              Strings.libraryPleaseSignIn,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          GoogleSignInButton(
            viewModel: viewModel,
          )
        ],
      )
//            : const CircularProgressIndicator(),
          ),
    );
  }
}
