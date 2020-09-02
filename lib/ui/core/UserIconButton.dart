import 'package:avgleclient/ui/profile/profile_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserIconButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
              Navigator.push<Widget>(
                  context, MaterialPageRoute(builder: (_) => ProfilePage()));
            },
          ),
        ),
      ),
    );
  }
}
