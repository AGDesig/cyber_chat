

import 'package:flutter/material.dart';
import 'package:social_app/res/components/app_texts.dart';
import 'package:social_app/res/components/custom_base_scaffold.dart';
import 'package:social_app/utils/app_strings.dart';
class ProfileSetupView extends StatelessWidget {
  const ProfileSetupView({super.key});

  @override
  Widget build(BuildContext context) {
    return baseScaffold(body: Column(children: [
      appText("$signIn")
    ],));
  }
}
