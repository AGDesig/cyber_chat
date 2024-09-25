import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_app/res/navigation_bar_widget.dart';
import 'package:social_app/utils/app_routes.dart';

import '../Controllers/chat_controller.dart';
import '../Controllers/signin_controller.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: NavigationBarWidget(),);
  }



}
