import 'package:flutter/material.dart';
import 'package:ielts_cat/pages/reset_password_page.dart';

import '../pages/login_page.dart';
import '../pages/register_page.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  // Initially show the login page
  int currentPage = 0;

  // Toggle between login and register page
  void togglePages(int pageCount) {
    if (mounted) {
      setState(() {
        currentPage = pageCount;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (currentPage == 0) {
      return LoginPage(
        onTap: () => togglePages(1),
        onForgotTap: () => togglePages(2),
      );
    } else if (currentPage == 1) {
      return RegisterPage(
        onTap: () => togglePages(0),
        onForgotTap: () => togglePages(2),
      );
    } else {
      return ResetPasswordPage(onTap: () => togglePages(0));
    }
  }
}
