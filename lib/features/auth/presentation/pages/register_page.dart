import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ielts_cat/gen/assets.gen.dart';
import 'package:ielts_cat/services/auth_services.dart';

import '../../../../components/my_button.dart';
import '../../../../components/my_textfield.dart';
import '../../../../components/square_login_tile.dart';
import '../../../../helper/helper_functions.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;
  final void Function()? onForgotTap;

  const RegisterPage({
    super.key,
    required this.onTap,
    required this.onForgotTap,
  });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // Text controller
  final TextEditingController usernameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();

  // Current obscureText
  bool currentObscureText = true;

  // Register user
  void registerUser() {
    // Check the password and confirm password match
    if (passwordController.text != confirmPasswordController.text) {
      // Show error message to user
      showErrorMessageToUser("Passwords don't match!", context);
    } else {
      // Dispatch Signup Event
      context.read<AuthBloc>().add(
        AuthSignedUp(
          email: emailController.text,
          password: passwordController.text,
          username: usernameController.text,
        ),
      );
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
                Assets.animations.welcome.image(width: width / 3),

                const SizedBox(height: 15),

                // App name
                const Text("IELTS Cat", style: TextStyle(fontSize: 20)),

                const SizedBox(height: 50),

                // Email text field
                MyTextField(
                  hintText: "Full Name",
                  obscureText: false,
                  controller: usernameController,
                ),

                const SizedBox(height: 10),

                // Email text field
                MyTextField(
                  hintText: "Email",
                  obscureText: false,
                  controller: emailController,
                ),

                const SizedBox(height: 10),

                // Password text field
                MyTextField(
                  hintText: "Password",
                  obscureText: currentObscureText,
                  controller: passwordController,
                  suffixIcon: Icon(
                    Icons.remove_red_eye,
                    color: currentObscureText
                        ? Theme.of(context).colorScheme.inversePrimary
                        : Colors.black,
                  ),
                  suffixIconOnPressed: () {
                    setState(() {
                      currentObscureText = !currentObscureText;
                    });
                  },
                ),

                const SizedBox(height: 10),

                MyTextField(
                  hintText: "Confirm Password",
                  obscureText: currentObscureText,
                  controller: confirmPasswordController,
                  suffixIcon: Icon(
                    Icons.remove_red_eye,
                    color: currentObscureText
                        ? Theme.of(context).colorScheme.inversePrimary
                        : Colors.black,
                  ),
                  suffixIconOnPressed: () {
                    setState(() {
                      currentObscureText = !currentObscureText;
                    });
                  },
                ),

                const SizedBox(height: 10),

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

                const SizedBox(height: 10),

                // Register button
                MyButton(text: "Register", onTap: registerUser),

                const SizedBox(height: 10),

                // Don't have an account? Register here
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account? "),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        "Login Here!",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                const Text("or", style: TextStyle(fontWeight: FontWeight.bold)),

                const SizedBox(height: 10),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SquareLoginTile(
                      image: Assets.icons.loginAndRegister.googleLogo.path,
                      onTap: () => AuthServices().signInWithGoogle(),
                    ),
                    const SizedBox(width: 20),
                    SquareLoginTile(
                      image: Assets.icons.loginAndRegister.appleLogo.path,
                      onTap: () {
                        showErrorMessageToUser(
                          "Registration with Apple isn’t integrated yet.",
                          context,
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
