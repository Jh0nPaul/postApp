import 'package:flutter/material.dart';

class InfoTextField extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final TextInputType inputType;
  final bool isPassword;
  final FormFieldValidator<String>? validator;
  final Widget? icon;
  final IconData? iconData;
  InfoTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    required this.inputType,
    required this.isPassword,
    this.validator,
    this.icon,
    this.iconData
  });

  late ThemeData theme;
  late Size size;
  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    size = MediaQuery.of(context).size;
    return Row(
      children: [
        SizedBox(
          width: size.width * .2,
          child: TextFormField(
            controller: controller,
            keyboardType: inputType,
            obscureText: isPassword,
            validator: validator,
            style: const TextStyle(color: Colors.black , fontSize: 15, fontWeight: FontWeight.w400),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 14),
              hintText:  hint.isEmpty ? 'Enter text' : hint,
              hintStyle: const TextStyle(color: Colors.black),
              labelStyle: const TextStyle(color: Colors.black),
              hoverColor: Colors.grey.withValues(alpha: 0.5),
              focusedBorder: OutlineInputBorder(
                borderSide:  BorderSide(
                    color:
                    // Colors.black.withValues(alpha: 100)
                    theme.colorScheme.primaryContainer
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color:
                    theme.colorScheme.primaryContainer
                    // Colors.grey.withValues(alpha: 100)
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              errorBorder: OutlineInputBorder(
                gapPadding: 1,
                borderSide: BorderSide(color: Colors.red),
                borderRadius: BorderRadius.circular(8),
              ),
              filled: true,
              fillColor: Colors.white.withValues(alpha: 0.5),
              suffixIcon: icon,
            ),
          ),
        ),
        Icon(iconData)
      ],
    );
  }
}
