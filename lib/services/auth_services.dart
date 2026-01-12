import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthServices {
  static bool _isGoogleSignInInitialized = false;

  // Continue with Google sign-in and store user info in Firestore
  Future<void> signInWithGoogle() async {
    // Begin interface with sign-in process
    if (!_isGoogleSignInInitialized) {
      await GoogleSignIn.instance.initialize(
        clientId:
            "302292436063-6aoufmepoio6cq6lh506t2bpstkb6mqe.apps.googleusercontent.com",
      );
      _isGoogleSignInInitialized = true;
    }

    final GoogleSignInAccount gUser;
    try {
      gUser = await GoogleSignIn.instance.authenticate();
    } catch (e) {
      // Handle cancellation or error
      return;
    }

    // Obtain auth with form request
    final GoogleSignInAuthentication gAuth = gUser.authentication;

    // Create a new credential for user
    final credential = GoogleAuthProvider.credential(
      accessToken: null,
      idToken: gAuth.idToken,
    );

    // Finally let's sign in
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithCredential(credential);

    // After sign-in, automatically save the user info if it doesn't exist
    if (userCredential.user != null) {
      final userDoc = await FirebaseFirestore.instance
          .collection("Users")
          .doc(userCredential.user!.email)
          .get();

      // If the user document doesn't exist, save the displayName as username
      if (!userDoc.exists) {
        String username =
            userCredential.user!.displayName ??
            'User'; // Fallback to 'User' if no displayName

        // Save the user data in Firestore
        await FirebaseFirestore.instance
            .collection("Users")
            .doc(userCredential.user!.email)
            .set({'email': userCredential.user!.email, 'username': username});
      }
    }
  }
}
