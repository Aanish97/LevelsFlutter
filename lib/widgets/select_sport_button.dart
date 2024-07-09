import 'package:flutter/material.dart';
import 'package:levels_athletes_coaches/constants/app_text_styles.dart';

import '../constants/app_colors.dart';

class SelectSportButton extends StatelessWidget {
  final String title;
  final Function() onTap;
  final bool isTransparent;
  final Color textColor;
  final double height;
  final String imagePath;

   SelectSportButton(
      {Key? key,
      required this.title,
      required this.onTap,
      required this.imagePath,
      required this.isTransparent,
      required this.textColor,
      required this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.primaryColor, width: 2),
          borderRadius: BorderRadius.circular(10),
          color: (isTransparent) ? Colors.transparent : AppColors.primaryColor,
        ),
        height: height,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(imagePath,height: 40,),
            const SizedBox(width: 20,),
            SizedBox(
              width: 100,
              child: Text(
                title,
                style: montserratBold.copyWith(
                  color: textColor,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
