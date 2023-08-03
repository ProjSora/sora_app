/*
  This file is used to display the home screen of the app.
*/

import 'package:flutter/material.dart';
import 'package:sora/screens/Home/home.dart';
import 'package:sora/screens/Chat/chat.dart';
import 'package:sora/screens/Post/post.dart';
import 'package:sora/screens/Profile/profile.dart';

class HomeNavigationBar extends StatefulWidget {
  const HomeNavigationBar({Key? key}) : super(key: key);

  // This widget is the home page of the app.
  @override
  State<HomeNavigationBar> createState() => _NavigatorState();
}

class _NavigatorState extends State<HomeNavigationBar> {
  int currentPageIndex = 0;

  @override
  // This is the state of the home page.
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.chat),
            label: 'Chat',
          ),
          NavigationDestination(
            icon: Icon(Icons.post_add),
            label: 'Post',
          ),
          NavigationDestination(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
      body: IndexedStack(
        index: currentPageIndex,
        children: const <Widget>[
          HomePage(),
          ChatPage(),
          PostPage(),
          ProfilePage(),
        ],
      ),
    );
  }
}