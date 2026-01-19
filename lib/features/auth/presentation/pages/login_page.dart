import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ielts_cat/components/square_login_tile.dart';
import 'package:ielts_cat/gen/assets.gen.dart';
import 'package:ielts_cat/services/auth_services.dart';

import '../../../../components/my_button.dart';
import '../../../../components/my_textfield.dart';
import '../../../../helper/helper_functions.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';

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
  void loginUser() {
    // Dispatch Login Event
    context.read<AuthBloc>().add(
      AuthLoggedIn(
        email: emailController.text,
        password: passwordController.text,
      ),
    );
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
                  hintText: "Email",
                  obscureText: false,
                  controller: emailController,
                ),

                const SizedBox(height: 10),

                // Password text field
                MyTextField(
                  hintText: "Password",
                  obscureText: currentObscureText,
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
                  controller: passwordController,
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

                // Login button
                MyButton(text: "Login", onTap: loginUser),

                const SizedBox(height: 10),

                // Don't have an account? Register here
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?"),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        "Register Here!",
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
                          "Login with Apple isn’t integrated yet.",
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
