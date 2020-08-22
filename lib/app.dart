import 'package:avgleclient/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final appNotifierProvider =
    ChangeNotifierProvider((ref) => AppNotifierProvider(ref));

class AppNotifierProvider extends ChangeNotifier {
  AppNotifierProvider(ProviderReference ref);
  int currentIndex = 0;

  void onTapped(int index) {
    currentIndex = index;
    notifyListeners();
  }
}

class App extends HookWidget {
  final List<Widget> _pages = [
    HomePage('ホーム'),
    HomePage('ほーむ'),
    HomePage('Home'),
  ];
  final bottomNavItems = [
    const BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('ホーム')),
    const BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('ホーム')),
    const BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('ホーム')),
  ];

  @override
  Widget build(BuildContext context) {
    final appNotifier = useProvider(appNotifierProvider);
    return MaterialApp(
      title: 'Avgle',
      home: Scaffold(
        body: _pages[appNotifier.currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          fixedColor: Colors.black,
          unselectedItemColor: Colors.grey,
          onTap: (index) => appNotifier.onTapped(index),
          currentIndex: appNotifier.currentIndex,
          type: BottomNavigationBarType.shifting,
          items: bottomNavItems,
        ),
      ),
    );
  }
}
