import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final Icon? suffixIcon;
  final void Function()? suffixIconOnPressed;
  final TextEditingController controller;

  const MyTextField({
    super.key,
    required this.hintText,
    required this.obscureText,
    this.suffixIcon,
    this.suffixIconOnPressed,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            12.0,
          ),
        ),
        suffixIcon: suffixIcon != null
            ? IconButton(
                onPressed: suffixIconOnPressed,
                icon: suffixIcon!,
              )
            : null,
      ),
    );
  }
}
