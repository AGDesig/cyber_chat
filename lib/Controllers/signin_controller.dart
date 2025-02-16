import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:html' as html; // Required for web interactions
import 'dart:ui' as ui; // Required for registering custom elements
import 'package:flutter/foundation.dart';
import 'package:google_sign_in_web/google_sign_in_web.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:social_app/View/profile_setup_screen/controller/profile_setup_controller.dart';
import 'package:social_app/utils/app_routes.dart';

import '../main.dart';

class SignInController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  ProfileSetupController profileSetupController = Get.put(ProfileSetupController());
  User? get _currentUser => _auth.currentUser;
  String get currentUserUid => _currentUser?.uid ?? '';
  String get currentUserName => _currentUser?.displayName ?? '';
  String get currentUserImageUrl => _currentUser?.photoURL ?? '';

  final GoogleSignIn googleSignIn = GoogleSignIn(clientId: "106733356500-0cvv0jqng8vj6mm0ho64jpt0i4005cm5.apps.googleusercontent.com",scopes: ['email'],);
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var user = Rxn<User>();
@override
  void onInit() {
  super.onInit();
  }

  Future<void> googleLogin() async {
    // GoogleSignInPlugin().init(clientId: "106733356500-0cvv0jqng8vj6mm0ho64jpt0i4005cm5.apps.googleusercontent.com",scopes: ["email"]);
    try {
      final GoogleSignInAccount? googleUser;
      if(kIsWeb){
         googleUser = await googleSignIn.signIn();
          // GoogleSignInPlugin().renderButton(configuration: GSIButtonConfiguration());

      }else{
        googleUser = await googleSignIn.signIn();

      }
      if (googleUser == null) return;
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      UserCredential userCredential = await _auth.signInWithCredential(credential);

      // Store user info in Firestore
      if(userCredential.user !=null){
        await setUserData(userCredential.user);
      }
      var user =await profileSetupController.getUserProfile(currentUserUid);
      final userProfile = user.data() as Map<String, dynamic>;
     String isProfileAlreadySet=  userProfile["isProfileAlreadySet"];
      if(isProfileAlreadySet =="true"){
        Get.offAllNamed(AppRoutes.home);
      }else{
        Get.offAllNamed(AppRoutes.profileSetup);
      }

    } catch (e) {
      print("Error during Google Sign-In: $e");
    }
  }

  Future<void> setUserData(User? user) async {
    if (user != null) {
      final userRef = _firestore.collection('users').doc(user.uid);
      final profileRef = _firestore.collection('users').doc(user.uid).collection("profile").doc(user.uid);
      await profileRef.set({
        'uid': user.uid,
        'name': user.displayName,
        'email': user.email,
        'isProfileAlreadySet': "",
        'photoUrl': user.photoURL,
      }, SetOptions(merge: true));
      await userRef.set({
        'uid': user.uid,
        'userName': user.displayName,
        'displayName': user.displayName,
        "bio":"",
        "interest":"",
        "location":"",
        'photoUrl': user.photoURL,
      }, SetOptions(merge: true));

    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    await googleSignIn.signOut();
    Get.offAllNamed(AppRoutes.login);
  }
}
