import 'package:flutter/material.dart';

class CustomLoginTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final FormFieldValidator<String>? validator;
  final Widget? suffixIcon;
  const CustomLoginTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    this.validator,
    this.suffixIcon,
  });
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return TextFormField(
      cursorColor: Colors.black,
      style: const TextStyle(color: Colors.black),
      controller: controller,
      obscureText: obscureText,
      validator: validator,
      decoration: InputDecoration(
        labelStyle: const TextStyle(color: Colors.black),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        hintText: hintText.isEmpty ? 'Enter text' : hintText,
        hintStyle:  TextStyle(color: Colors.black),
        focusedBorder: OutlineInputBorder(
          borderSide:  BorderSide(color:
          // Colors.black.withValues(alpha: 100)
            theme.colorScheme.onPrimaryContainer
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color:
              theme.colorScheme.onPrimaryContainer
              //  Colors.grey.withValues(alpha: 0.5)
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(8),
        ),
        filled: true,
        fillColor: Colors.white.withValues(alpha: 0.5),
        suffixIcon: suffixIcon,
      ),
    );
  }
}
