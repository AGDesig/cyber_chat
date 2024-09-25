import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_app/Controllers/signin_controller.dart';
import 'package:social_app/utils/app_routes.dart';

class SignInPage extends StatelessWidget {
  final SignInController _signInController = Get.put(SignInController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(mainAxisSize: MainAxisSize.max,mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.g_mobiledata,size: 100,),
            ElevatedButton(
              onPressed: () async {
                await _signInController.googleLogin();
              },
              child: Text("Sign in with Google"),
            ),
          ],
        )
      ),
    );
  }
}
