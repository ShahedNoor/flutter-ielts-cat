import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/my_button.dart';
import '../components/my_textfield.dart';
import '../helper/helper_functions.dart';

class ResetPasswordPage extends StatefulWidget {
  final void Function()? onTap;

  const ResetPasswordPage({super.key, required this.onTap});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  // Text controller
  final TextEditingController emailController = TextEditingController();

  // Current obscureText
  bool currentObscureText = true;

  // Login method
  void loginUser() async {
    // Save the current context
    final currentContext = context;

    // Show circle progress indicator
    showDialog(
      context: currentContext,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    // Try to reset password
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text);

      // Pop the circle progress indicator if still mounted
      if (currentContext.mounted) Navigator.pop(currentContext);
      if (currentContext.mounted) emailController.clear();

      // Display success message if the reset email was sent successfully
      if (currentContext.mounted) {
        showErrorMessageToUser(
            "If an account exists for this email, a password reset email has been sent.",
            currentContext);
      }
    }

    // If can't reset password then display an error
    on FirebaseAuthException catch (e) {
      // Pop the circle progress indicator if still mounted
      if (currentContext.mounted) Navigator.pop(currentContext);

      if (currentContext.mounted) {
        showErrorMessageToUser(
          e.code == "missing-email"
              ? "The email field is empty. Please enter your email to reset your password."
              : e.code == "invalid-email"
                  ? "The email you entered isn't quite right."
                  : e.code == "network-request-failed"
                      ? "Oops, it seems like there's an issue with your internet connection."
                      : e.code == "channel-error"
                          ? "The app failed to communicate with servers properly. This might happen due to an unstable internet connection or issues with server infrastructure."
                          : e.code,
          currentContext,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Media query
    final width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo
                Image.asset(
                  "assets/animations/welcome.gif",
                  width: width / 3,
                ),

                const SizedBox(
                  height: 15,
                ),

                // App name
                const Text(
                  "IELTS's Cat",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),

                const SizedBox(
                  height: 50,
                ),

                // Email text field
                MyTextField(
                  hintText: "Email",
                  obscureText: false,
                  controller: emailController,
                ),

                const SizedBox(
                  height: 10,
                ),

                const SizedBox(
                  height: 10,
                ),

                const SizedBox(
                  height: 10,
                ),

                // Login button
                MyButton(text: "Reset Password", onTap: loginUser),

                const SizedBox(
                  height: 10,
                ),

                // Don't have an account? Register here
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Password reset complete?"),
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        "Login Here!",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
