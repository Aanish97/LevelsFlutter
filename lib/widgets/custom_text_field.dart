import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:levels_athletes_coaches/constants/app_text_styles.dart';
import 'package:levels_athletes_coaches/constants/app_colors.dart';
import 'package:levels_athletes_coaches/constants/app_sizes.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool? isObscure;
  final bool? isReadOnly;
  final String? obscureCharacter;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatter;
  final void Function(String)? onChanged;
  final Widget? suffixIcon;
  final TextInputAction? textInputAction;
  final int? minLines;
  final int? maxLines;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.isReadOnly=false,
    this.isObscure = false,
    this.obscureCharacter = '*',
    this.keyboardType,
    this.validator,
    this.inputFormatter,
    this.onChanged,
    this.suffixIcon,
    this.textInputAction = TextInputAction.next,
    this.minLines = 1,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return

        /// field
        TextFormField(
      controller: controller,
      obscureText: isObscure!,
      readOnly: isReadOnly!,
      obscuringCharacter: obscureCharacter!,
      keyboardType: keyboardType,
      validator: validator,
      inputFormatters: inputFormatter,
      onChanged: onChanged,
      textInputAction: textInputAction,
      style: montserratMedium.copyWith(
        fontSize: kFont14,
        color: AppColors.blackColor,
      ),
      minLines: minLines,
      maxLines: maxLines,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.textFieldFillColor,
        hintText: hintText,
        hintStyle: montserratRegular.copyWith(
          fontSize: kFont14,
          color: AppColors.hintTextColor.withOpacity(0.7),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: kPadding16,
          vertical: kPadding14,
        ),
        suffixIcon: suffixIcon,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(kRadius13),
            borderSide:const  BorderSide(color: Colors.transparent)
        ),
        border: InputBorder.none,
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(kRadius13),
            borderSide:const  BorderSide(color: Colors.transparent)
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(kRadius13),
            borderSide:const  BorderSide(color: Colors.transparent)
        ),
      ),
    );
  }
}
