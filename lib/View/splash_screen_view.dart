import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_app/Controllers/splash_screen_controller.dart';

class SplashScreenView extends StatelessWidget {
   SplashScreenView({super.key});

   final controller = Get.put(SplashScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Icon(Icons.chat_bubble,color: Colors.amber,size: 50,),
            Text("Social App",style: TextStyle(color: Colors.black,fontSize: 25),),
          ],
        ),
      ),
    );
  }
}
