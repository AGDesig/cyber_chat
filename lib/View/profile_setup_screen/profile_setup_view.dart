import 'package:flutter/material.dart';
import 'package:social_app/res/components/app_texts.dart';
import 'package:social_app/res/components/custom_base_scaffold.dart';
import 'package:social_app/utils/app_strings.dart';

import '../../utils/app_colors.dart';

class ProfileSetupView extends StatelessWidget {
  const ProfileSetupView({super.key});

  @override
  Widget build(BuildContext context) {
    return baseScaffold(
        body: Column(
      children: [
        appText(createNewProfile),
        Container(
          height: 150,
          width: 150,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.gray,
          ),
          child: Align(alignment: Alignment.center,child: Image(height: 80,width: 80,image: AssetImage("assets/icon/icon_camera.png",),color: AppColors.white,)),
        ),

      ],
    ));
  }
}
