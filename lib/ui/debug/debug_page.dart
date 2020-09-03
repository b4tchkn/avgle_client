import 'package:avgleclient/res/app_colors.dart';
import 'package:avgleclient/res/strings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class DebugPage extends StatelessWidget {
  final auth = FirebaseAuth.instance;
  final googleSignIn = GoogleSignIn();

  @override
  Widget build(BuildContext context) {
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
                  _signIn().then((value) => debugPrint(value.displayName));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<User> _signIn() async {
    var currentUser = googleSignIn.currentUser;
    try {
      currentUser ??= await googleSignIn.signIn();

      final googleAuth = await currentUser.authentication;
      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
      final user = (await auth.signInWithCredential(credential)).user;
      debugPrint('signed in $user');

      return user;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}
