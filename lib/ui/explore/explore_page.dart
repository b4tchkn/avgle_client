import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ExplorePage extends HookWidget {
  const ExplorePage(this.title);

  final String title;
  @override
  Widget build(BuildContext context) {
    debugPrint('Explore');
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Text('This is ExplorePage. Coming soon.'),
      ),
    );
  }
}
