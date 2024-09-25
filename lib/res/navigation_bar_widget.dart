import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_app/Controllers/chat_controller.dart';
import 'package:social_app/View/chat_screen_view.dart';
import 'package:social_app/View/friend_request_view.dart';
import 'package:social_app/View/post_screen_view.dart';
import 'package:social_app/View/profile_view.dart';
import 'package:social_app/res/widget_controller/navigation_bar_controller.dart';

import '../Controllers/signin_controller.dart';

class NavigationBarWidget extends StatelessWidget {
  NavigationBarWidget({super.key});


 final NavigationBarController _controller =  Get.find<NavigationBarController>( tag: "overall");

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return GetBuilder<NavigationBarController>(tag:"overall",builder: (logic) {
      return Scaffold(
        bottomNavigationBar: NavigationBar(
          onDestinationSelected: (int index) {
           logic.setCurrentPageIndex(index);
          },
          indicatorColor: Colors.amber,
          selectedIndex: logic.currentPageIndex,
          destinations: const <Widget>[
            NavigationDestination(
              selectedIcon: Icon(Icons.home),
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.person_add),
              label: 'Friends',
            ),
            NavigationDestination(
              icon: Icon(Icons.message),
              label: 'Messages',
            ),
            NavigationDestination(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
        ),
        body: <Widget>[

         // PostScreen(),
          Center(child: Text("UnderConstruction"),),
          FriendRequestScreen(),
          ChatScreenView(),
          ProfileScreen(),

        ][logic.currentPageIndex],
      );
    });
  }
}
