import 'package:flutter/material.dart';

class SelectSportButton extends StatelessWidget {
  final String title;
  final Function() onTap;
  final bool isTransparent;
  final Color textColor;
  final double height;

  const SelectSportButton(
      {Key? key,
      required this.title,
      required this.onTap,
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
          border: Border.all(color: Colors.red, width: 2),
          borderRadius: BorderRadius.circular(10),
          color: (isTransparent) ? Colors.transparent : Colors.red,
        ),
        height: height,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.sports_gymnastics,
              size: 22,
              color: Colors.white,
            ),
            Text(
              title,
              style: TextStyle(
                color: textColor,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
