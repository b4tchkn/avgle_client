import 'package:avgleclient/res/app_colors.dart';
import 'package:avgleclient/res/strings.dart';
import 'package:avgleclient/ui/debug/debug_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ProfilePage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance;
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.profileAppBarTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              if (auth.currentUser != null)
                Text(auth.currentUser.toString())
              else
                const Text('ログインしてね'),
              const Divider(),
              FlatButton(
                child: const Text(Strings.debugPageTitle),
                color: AppColors.lightGrey,
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(builder: (_) => DebugPage()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
