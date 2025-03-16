import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:social_app/Controllers/signin_controller.dart';
import 'package:social_app/res/components/app_button.dart';
import 'package:social_app/res/components/app_texts.dart';
import 'package:social_app/res/components/custom_base_scaffold.dart';
import 'package:social_app/utils/app_routes.dart';
import 'package:social_app/utils/app_strings.dart';
import 'package:social_app/utils/screen_size.dart';

class SignInPage extends StatelessWidget {
  SignInPage({super.key});
  final SignInController _signInController = Get.put(SignInController());
  @override
  Widget build(BuildContext context) {
    return baseScaffold(
      body: ScreenTypeLayout.builder(
        mobile: (p0) => signInViewWidget(
            logoImageHeight: 250,
            logoImageWidth: 250,
            mainAxisAlignment: MainAxisAlignment.center,
        ),
        tablet: (p0) => signInViewWidget(
          logoImageHeight: 450,
          logoImageWidth: 450,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          fontSize: 50,
          fontSize2: 32,
          hasSizedBox: false

        ),
        desktop: (p0) => signInViewDesktop(
            logoImageHeight: 450,
            logoImageWidth: 450,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            fontSize: 75,
            fontSize2: 45,
            hasSizedBox: false,
            isMobile: false,
    ),
      ),
    );
  }

  Widget signInViewWidget(
      {double? logoImageHeight,
      double? logoImageWidth,
      MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
        double? fontSize,
        double? fontSize2,
        bool hasSizedBox = true,
        bool isMobile =true
      }) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: mainAxisAlignment,
        children: [
          Image.asset(
            "assets/images/black_triadz_logo.png",
            height: logoImageHeight,
            width: logoImageWidth,
          ),
          if(hasSizedBox)
            SizedBox(height: heightPercent *3,),
          appText("$welcomeTo $blackTriads family",
              fontSize: fontSize??30, fontWeight: FontWeight.w600),
          if(hasSizedBox)
            SizedBox(height: heightPercent *3,),
          appText("${continuee.capitalizeFirst} $withh $google $signIn",
              fontSize: fontSize2??18, fontWeight: FontWeight.w600),
          if(hasSizedBox)
            SizedBox(height: heightPercent *3,),
          isMobile? appButton(
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
            border: Border.all(
              color: Colors.grey.withOpacity(0.2),
              width: 1,
            ),
            color: Colors.white,
            textColor: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.w700,
            padding: EdgeInsets.all(15),
            margin: EdgeInsets.symmetric(horizontal: 20),
            borderRadius: BorderRadius.circular(10),
            text: "$signIn $withh $google",
          ):  appButton(
            onTap: () {
              _signInController.googleLogin();
            },
            havePrefix: true,
            haveSize: true,
            height: 118,
            width: 118,
            icon: Image.asset(
              "assets/icon/icon_google.png",
              height: 74,
              width: 74,
            ),
            border: Border.all(
              color: Colors.grey.withOpacity(0.2),
              width: 1,
            ),
            color: Colors.white,
            shape: BoxShape.circle,
      
      
          )
        ],
      ),
    );
  }
  Widget signInViewDesktop(
      {double? logoImageHeight,
        double? logoImageWidth,
        MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
        double? fontSize,
        double? fontSize2,
        bool hasSizedBox = true,
        bool isMobile =true
      }) {
    return Container(
      height: Get.height,width: Get.width,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: mainAxisAlignment,
          children: [
            Image.asset(
              "assets/images/black_triadz_logo.png",
              height: logoImageHeight,
              width: logoImageWidth,
            ),
            if(hasSizedBox)
              SizedBox(height: heightPercent *3,),
            appText("$welcomeTo $blackTriads family",
                fontSize: fontSize??30, fontWeight: FontWeight.w600),
            if(hasSizedBox)
              SizedBox(height: heightPercent *3,),
            appText("${continuee.capitalizeFirst} $withh $google $signIn",
                fontSize: fontSize2??18, fontWeight: FontWeight.w600),
            if(hasSizedBox)
              SizedBox(height: heightPercent *3,),
            isMobile? appButton(
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
              border: Border.all(
                color: Colors.grey.withOpacity(0.2),
                width: 1,
              ),
              color: Colors.white,
              textColor: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.w700,
              padding: EdgeInsets.all(15),
              margin: EdgeInsets.symmetric(horizontal: 20),
              borderRadius: BorderRadius.circular(10),
              text: "$signIn $withh $google",
            ):  appButton(
              onTap: () {
                _signInController.googleLogin();
              },
              havePrefix: true,
              haveSize: true,
              height: 118,
              width: 118,
              icon: Image.asset(
                "assets/icon/icon_google.png",
                height: 74,
                width: 74,
              ),
              border: Border.all(
                color: Colors.grey.withOpacity(0.2),
                width: 1,
              ),
              color: Colors.white,
              shape: BoxShape.circle,
            )
          ],
        ),
      ),
    );
  }
}
