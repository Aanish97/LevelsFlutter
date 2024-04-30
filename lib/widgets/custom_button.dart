import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final Function() onTap;
  final bool isTransparent;
  final Color textColor;
  final double height;
  final Widget? child;

  const CustomButton(
      {Key? key,
      required this.title,
      required this.onTap,
      required this.isTransparent,
      required this.textColor,
      required this.height,
      this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.red, width: 2),
          borderRadius: BorderRadius.circular(10),
          color: (isTransparent) ? Colors.transparent : Colors.red,
        ),
        height: height,
        child: Center(
          child: child ??
              Text(
                title,
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
        ),
      ),
    );
  }
}
