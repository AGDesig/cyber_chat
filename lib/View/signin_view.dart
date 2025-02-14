import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_app/Controllers/signin_controller.dart';
import 'package:social_app/res/components/app_button.dart';
import 'package:social_app/res/components/app_texts.dart';
import 'package:social_app/utils/app_routes.dart';
import 'package:social_app/utils/app_strings.dart';

class SignInPage extends StatelessWidget {
  SignInPage({super.key});
  final SignInController _signInController = Get.put(SignInController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(0.1),
      body: Center(
          child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/images/cyber_logo.png",height: 100,width: 100,),
          appText("$welcomeTo $cyber $chat",fontSize: 18,fontWeight: FontWeight.w600),
          appText("${continuee.capitalizeFirst} $withh $google $signIn",fontSize: 18,fontWeight: FontWeight.w600),
          appButton(
            onTap: () {
              _signInController.googleLogin();
            },
            havePrefix: true,
            haveSize: false,
            icon: Image.asset(
              "assets/icon/icon_google.png",
              height: 24,
              width: 24,
            ),
            border: Border.all(color: Colors.grey.withOpacity(0.2),width: 1,),
            color: Colors.white,
            textColor: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.w700,
            padding: EdgeInsets.all(15),
            margin: EdgeInsets.symmetric(horizontal: 20),
            borderRadius: BorderRadius.circular(10),
            text: "$signIn $withh $google",
          )
        ],
      )),
    );
  }
}
