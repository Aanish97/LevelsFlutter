import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class InputField extends StatelessWidget {
  final String? hintText;
  final bool obscureText;
  final Widget suffixIcon;
  final TextEditingController controller;
  final String? Function(String?)? textFieldValidator;
  final TextInputType keyboardType;

  const InputField(
      {Key? key,
      this.hintText,
      this.obscureText = false,
      required this.suffixIcon,
      required this.controller,
      this.textFieldValidator,
      required this.keyboardType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: textFieldValidator,
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
        filled: true,
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(13)),
        ),
        hintText: hintText ?? "name",
        errorStyle: const TextStyle(
          color: Colors.red,
        ),
        fillColor: AppColors.textFieldFillColor,
        hintStyle: const TextStyle(
          color: Colors.grey,
        ),
        suffixIcon: suffixIcon,
      ),
      keyboardType: keyboardType,
      style: const TextStyle(
        color: Colors.black,
      ),
    );
  }
}
