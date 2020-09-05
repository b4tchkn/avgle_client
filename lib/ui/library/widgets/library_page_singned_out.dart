import 'package:avgleclient/res/strings.dart';
import 'package:avgleclient/ui/core/google_sign_in_button.dart';
import 'package:avgleclient/ui/library/library_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LibraryPageSignedOut extends StatelessWidget {
  const LibraryPageSignedOut({@required LibraryViewModel viewModel})
      : _viewModel = viewModel;

  final LibraryViewModel _viewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 300,
            child: Lottie.network(
                'https://assets8.lottiefiles.com/private_files/lf30_imyUMa.json'),
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
            viewModel: _viewModel,
          )
        ],
      )
//            : const CircularProgressIndicator(),
          ),
    );
  }
}
