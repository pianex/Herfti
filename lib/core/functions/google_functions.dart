import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

void signInWithGoogle({
  required BuildContext context,
  required Function onSuccess,
}) async {
  // Trigger the authentication flow
  try {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    User? user = (await FirebaseAuth.instance.signInWithCredential(
      credential,
    )).user;

    if (user != null) {
      // _uid = user.uid;
      // sharedPref.setString('email', user.email!);
      // debugPrint("/////////////////////////// ${user.photoURL}");
      // sharedPref.setString('photoUrl', user.photoURL!);
      // onSuccess();
      // _otpIsVerified = true;
    }
    // sharedPref.setString("userEmail", user!.email!);
  } on FirebaseAuthException catch (e) {
    debugPrint(e.message);
  }
}
