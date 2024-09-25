import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:social_app/utils/app_routes.dart';

class SignInController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? get _currentUser => _auth.currentUser;
  String get currentUserUid => _currentUser?.uid ?? '';
  String get currentUserName => _currentUser?.displayName ?? '';
  String get currentUserImageUrl => _currentUser?.photoURL ?? '';

  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var user = Rxn<User>();


  Future<void> googleLogin() async {
    try {

      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
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
