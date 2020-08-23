import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ExplorePage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    debugPrint('Explore');
    return Scaffold(
      body: Center(
        child: Material(
          elevation: 4.0,
          shape: CircleBorder(),
          clipBehavior: Clip.hardEdge,
          color: Colors.transparent,
          child: Ink.image(
            image: NetworkImage('https://avgle.com/media/users/nopic-Male.gif'),
            fit: BoxFit.cover,
            width: 120.0,
            height: 120.0,
            child: InkWell(
              onTap: () {},
            ),
          ),
        ),
      ),
    );
  }
}
