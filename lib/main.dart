import 'package:avgleclient/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() => runApp(ProviderScope(child: App()));

//class MyApp extends HookWidget {
//  @override
//  Widget build(BuildContext context) {
//    final mainViewModel = useProvider(mainViewModelNotifierProvider);
//
//    return MaterialApp(
//      title: 'Flutter Demo',
//      theme: ThemeData(
//        primarySwatch: Colors.blue,
//        visualDensity: VisualDensity.adaptivePlatformDensity,
//      ),
//      home: Scaffold(
//        appBar: AppBar(
//          title: Text('Example'),
//        ),
//        body: Center(
//          child: Text(mainViewModel.count.toString()),
//        ),
//        floatingActionButton: FloatingActionButton(
//          onPressed: () => mainViewModel.increment(),
//          child: Icon(Icons.add),
//        ),
//      ),
//    );
//  }
//}
