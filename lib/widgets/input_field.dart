import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class InputField extends StatelessWidget {
  final String? hintText;
  final bool obscureText;
  final bool? readOnly;
  final Widget suffixIcon;
  VoidCallback? onTap;
  final TextEditingController controller;
  final String? Function(String?)? textFieldValidator;
  final TextInputType keyboardType;
  int maxLines;
  int minlines;

   InputField({Key? key,
    this.hintText,
     this.readOnly = false,
    required this.onTap,
    this.obscureText = false,
    required this.suffixIcon,
    required this.controller,
    this.textFieldValidator,
    required this.keyboardType, this.maxLines=2, this.minlines=1})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: textFieldValidator,
      controller: controller,
      obscureText: obscureText,
      readOnly: readOnly!,
      onTap:onTap!,
      minLines: minlines,
      maxLines: maxLines,
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
