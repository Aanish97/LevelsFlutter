import 'package:flutter/material.dart';

import 'package:levels_athletes_coaches/constants/app_colors.dart';
import 'package:levels_athletes_coaches/constants/app_sizes.dart';
import 'package:levels_athletes_coaches/constants/app_text_styles.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final Function() onTap;
  final bool isTransparent;
  final Color textColor;
  final Color buttonColor;
  final double fontSize;
  final double height;
  final Widget? child;

  const CustomButton(
      {Key? key,
      required this.title,
      required this.onTap,
      required this.isTransparent,
      required this.textColor,
      required this.height,
      this.fontSize = kFont14,
      this.buttonColor = AppColors.buttonFillColor,
      this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.buttonFillColor, width: 2),
          borderRadius: BorderRadius.circular(13),
          color:
              (isTransparent) ? Colors.transparent : buttonColor,
        ),
        height: height,
        child: Center(
          child: child ??
              Text(
                title,
                style: montserratBold.copyWith(
                  color: textColor,
                  fontSize: fontSize,
                ),
              ),
        ),
      ),
    );
  }
}
