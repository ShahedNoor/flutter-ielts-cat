import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthServices {
  // Continue with Google sign-in and store user info in Firestore
  Future<void> signInWithGoogle() async {
    // Begin interface with sign-in process
    final GoogleSignInAccount? gUser = await GoogleSignIn(
            clientId:
                "302292436063-6aoufmepoio6cq6lh506t2bpstkb6mqe.apps.googleusercontent.com")
        .signIn();

    if (gUser == null) return; // User canceled the Google sign-in

    // Obtain auth with form request
    final GoogleSignInAuthentication gAuth = await gUser.authentication;

    // Create a new credential for user
    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );

    // Finally let's sign in
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    // After sign-in, automatically save the user info if it doesn't exist
    if (userCredential.user != null) {
      final userDoc = await FirebaseFirestore.instance
          .collection("Users")
          .doc(userCredential.user!.email)
          .get();

      // If the user document doesn't exist, save the displayName as username
      if (!userDoc.exists) {
        String username = userCredential.user!.displayName ??
            'User'; // Fallback to 'User' if no displayName

        // Save the user data in Firestore
        await FirebaseFirestore.instance
            .collection("Users")
            .doc(userCredential.user!.email)
            .set({
          'email': userCredential.user!.email,
          'username': username,
        });
      }
    }
  }
}
