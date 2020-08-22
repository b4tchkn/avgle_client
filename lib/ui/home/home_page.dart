import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class HomePage extends HookWidget {
  const HomePage(this.title);

  final String title;
  @override
  Widget build(BuildContext context) {
    debugPrint('home');
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Text('This is HomePage.'),
      ),
    );
  }
}
