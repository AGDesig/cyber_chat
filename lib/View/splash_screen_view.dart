import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:social_app/Controllers/splash_screen_controller.dart';
import 'package:social_app/res/components/custom_base_scaffold.dart';

class SplashScreenView extends StatelessWidget {
   SplashScreenView({super.key});

   final controller = Get.put(SplashScreenController());

  @override
  Widget build(BuildContext context) {
    return baseScaffold(
      body: ScreenTypeLayout.builder(
        mobile: (p0) => splashWidget(height: 250.95,width: 200.96),
        tablet: (p0) =>splashWidget(height: 350.95,width: 300.95),
        desktop: (p0) =>  splashWidget(height: 650.95,width: 500.95),

      ),
    );
  }

  Widget splashWidget({double? height,double? width}) {
    return Center(
      child: Column(mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset("assets/images/black_triadz_logo.png",height: height,width:width, ),
          ],
        ),
    );
  }
}
