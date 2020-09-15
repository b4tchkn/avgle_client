import 'package:avgleclient/ui/profile/profile_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class UserIconButton extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final user = snapshot.data;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Material(
              elevation: 4.0,
              shape: const CircleBorder(),
              clipBehavior: Clip.hardEdge,
              color: Colors.transparent,
              child: Ink.image(
                image: user == null
                    ? const NetworkImage(
                        'https://avgle.com/media/users/nopic-Male.gif',
                      )
                    : NetworkImage(user.photoURL),
                fit: BoxFit.cover,
                width: 40.0,
                height: 40.0,
                child: InkWell(
                  onTap: () {
                    Navigator.push<Widget>(context,
                        MaterialPageRoute(builder: (_) => ProfilePage()));
                  },
                ),
              ),
            ),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Material(
              elevation: 4.0,
              shape: const CircleBorder(),
              clipBehavior: Clip.hardEdge,
              color: Colors.transparent,
              child: Ink.image(
                image: const NetworkImage(
                  'https://avgle.com/media/users/nopic-Male.gif',
                ),
                fit: BoxFit.cover,
                width: 40.0,
                height: 40.0,
                child: InkWell(
                  onTap: () {
                    Navigator.push<Widget>(context,
                        MaterialPageRoute(builder: (_) => ProfilePage()));
                  },
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
