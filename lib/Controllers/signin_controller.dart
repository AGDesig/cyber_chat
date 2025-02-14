import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:html' as html; // Required for web interactions
import 'dart:ui' as ui; // Required for registering custom elements
import 'package:flutter/foundation.dart';
import 'package:google_sign_in_web/google_sign_in_web.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:social_app/utils/app_routes.dart';

import '../main.dart';

class SignInController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
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
      await setUserData(userCredential.user);
      Get.offAllNamed(AppRoutes.home);
    } catch (e) {
      print("Error during Google Sign-In: $e");
    }
  }

  Future<void> setUserData(User? user) async {
    if (user != null) {
      final userRef = _firestore.collection('users').doc(user.uid);
      await userRef.set({
        'uid': user.uid,
        'name': user.displayName,
        'email': user.email,
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
