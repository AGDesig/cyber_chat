

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_app/Controllers/signin_controller.dart';
import 'package:social_app/utils/app_routes.dart';

class SplashScreenController extends GetxController {

  @override
  void onInit() async{
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    startSplash();
    super.onInit();
  }

  Future<void> startSplash()async {
    final SignInController _signInController = Get.put(SignInController());
    final FirebaseAuth _auth = FirebaseAuth.instance;
    _signInController.user.bindStream(_auth.authStateChanges());
    await ever(_signInController.user, _signInController.setUserData);

    if(_signInController.user.value != null){

      Get.offAllNamed(AppRoutes.home);

    }else{
      print("what is going on here${_signInController.user.value}");
      Get.offAllNamed(AppRoutes.login);
    }
  }
}