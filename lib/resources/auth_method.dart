import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:zoom_clone/utils/custom_snackbar.dart';

class AuthMethod {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<User?> get authChanges => auth.authStateChanges();
  User get user => auth.currentUser!;

  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      final credentials = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      UserCredential userCred = await auth.signInWithCredential(credentials);

      User? user = userCred.user;

      if (userCred.additionalUserInfo!.isNewUser) {
        _firestore.collection('users').doc(user!.uid).set({
          'name': user.displayName,
          "uid": user.uid,
          "profileImage": user.photoURL,
        });
      }
    } on FirebaseAuthException catch (error) {
      showSnackbar(context, error.message!);
      rethrow;
    }
  }

  Future<void> signOut() async => await auth.signOut();
}
