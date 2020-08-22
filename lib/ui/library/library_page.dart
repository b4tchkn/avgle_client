import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class LibraryPage extends HookWidget {
  const LibraryPage(this.title);

  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Text('This is LibraryPage. Coming soon.'),
      ),
    );
  }
}
