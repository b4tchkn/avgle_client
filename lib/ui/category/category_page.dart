import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CategoryPage extends HookWidget {
  const CategoryPage({@required String categoryName})
      : _categoryName = categoryName;

  final String _categoryName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_categoryName),
      ),
    );
  }
}
