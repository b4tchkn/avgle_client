import 'package:avgleclient/app_notifier.dart';
import 'package:avgleclient/data/provider/firebase_auth_provider.dart';
import 'package:avgleclient/res/app_colors.dart';
import 'package:avgleclient/res/strings.dart';
import 'package:avgleclient/ui/core/user_icon_button.dart';
import 'package:avgleclient/ui/explore/explore_page.dart';
import 'package:avgleclient/ui/home/home_page.dart';
import 'package:avgleclient/ui/library/library_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class App extends HookWidget {
  final List<Widget> _pages = [
    HomePage(),
    ExplorePage(),
    LibraryPage(),
  ];
  final bottomNavItems = [
    const BottomNavigationBarItem(
        icon: Icon(Icons.home), title: Text(Strings.bottomNavItemHomeTitle)),
    const BottomNavigationBarItem(
        icon: Icon(Icons.explore),
        title: Text(Strings.bottomNavItemExploreTitle)),
    const BottomNavigationBarItem(
        icon: Icon(Icons.video_library),
        title: Text(Strings.bottomNavItemLibraryTitle)),
  ];

  @override
  Widget build(BuildContext context) {
    final appNotifier = useProvider(appNotifierProvider);
    return MaterialApp(
      title: 'Avgle',
      theme: ThemeData(
        primaryColor: AppColors.grey,
      ),
      darkTheme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: Image.asset(
            'assets/images/logo.png',
            height: 40,
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {},
            ),
            UserIconButton(),
          ],
        ),
        body: _pages[appNotifier.currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          fixedColor: Colors.white,
          unselectedItemColor: AppColors.lightGrey,
          onTap: (index) => appNotifier.onTapped(index),
          currentIndex: appNotifier.currentIndex,
          type: BottomNavigationBarType.fixed,
          items: bottomNavItems,
        ),
      ),
    );
  }
}
