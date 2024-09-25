import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/my_button.dart';
import '../components/my_textfield.dart';
import '../helper/helper_functions.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;
  final void Function()? onForgotTap;

  const LoginPage({super.key, required this.onTap, required this.onForgotTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Text controller
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

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

    // Try to sign in user
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);

      // Pop the circle progress indicator if still mounted
      if (currentContext.mounted) Navigator.pop(currentContext);
    }

    // If can't login then display an error
    on FirebaseAuthException catch (e) {
      // Pop the circle progress indicator if still mounted
      if (currentContext.mounted) Navigator.pop(currentContext);

      if (currentContext.mounted) {
        showErrorMessageToUser(
          e.code == "invalid-email"
              ? "Looks like the email field is empty, or the email you entered isn't quite right."
              : e.code == "missing-password"
                  ? "Oops, it seems like your password is missing!"
                  : e.code == "invalid-credential"
                      ? "Invalid credentials. Please double-check your information and try again."
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
                  "assets/images/welcome.gif",
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

                // Password text field
                MyTextField(
                  hintText: "Password",
                  obscureText: currentObscureText,
                  suffixIcon: Icon(
                    Icons.remove_red_eye,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                  suffixIconOnPressed: () {
                    setState(() {
                      currentObscureText = !currentObscureText;
                    });
                  },
                  controller: passwordController,
                ),

                const SizedBox(
                  height: 10,
                ),

                // Forgot password
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: widget.onForgotTap,
                      child: Text(
                        "Forgot Password",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 10,
                ),

                // Login button
                MyButton(text: "Login", onTap: loginUser),

                const SizedBox(
                  height: 10,
                ),

                // Don't have an account? Register here
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?"),
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        "Register Here!",
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
