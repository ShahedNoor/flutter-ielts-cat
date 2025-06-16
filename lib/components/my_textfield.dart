import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String hintText;
  final String? labelText;
  final bool obscureText;
  final Icon? suffixIcon;
  final void Function()? suffixIconOnPressed;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const MyTextField({
    super.key,
    required this.hintText,
    this.labelText,
    required this.obscureText,
    this.suffixIcon,
    this.suffixIconOnPressed,
    required this.controller,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
        suffixIcon: suffixIcon != null
            ? IconButton(onPressed: suffixIconOnPressed, icon: suffixIcon!)
            : null,
      ),
      validator: validator,
    );
  }
}
