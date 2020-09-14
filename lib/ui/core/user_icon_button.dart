import 'package:avgleclient/data/provider/firebase_auth_provider.dart';
import 'package:avgleclient/ui/profile/profile_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UserIconButton extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final auth = useProvider(firebaseAuthProvider);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        elevation: 4.0,
        shape: const CircleBorder(),
        clipBehavior: Clip.hardEdge,
        color: Colors.transparent,
        child: Ink.image(
          image: auth.currentUser == null
              ? const NetworkImage(
                  'https://avgle.com/media/users/nopic-Male.gif',
                )
              : NetworkImage(auth.currentUser.photoURL),
          fit: BoxFit.cover,
          width: 40.0,
          height: 40.0,
          child: InkWell(
            onTap: () {
              Navigator.push<Widget>(
                  context, MaterialPageRoute(builder: (_) => ProfilePage()));
            },
          ),
        ),
      ),
    );
  }
}
