import 'package:flutter/material.dart';
import 'package:levels_athletes_coaches/constants/app_sizes.dart';
import 'package:levels_athletes_coaches/constants/app_text_styles.dart';

import '../constants/app_colors.dart';

class ClickableCard extends StatefulWidget {
  final String imagePath;
  final String title;
  final Color color;
  final Color colorLight;
  final Function() onTap;

  const ClickableCard({
    Key? key,
    required this.imagePath,
    required this.title,
    required this.color,
    required this.colorLight,
    required this.onTap,
  }) : super(key: key);

  @override
  State<ClickableCard> createState() => _ClickableCardState();
}

class _ClickableCardState extends State<ClickableCard> {
  Color borderColor = const Color(0xFF707070);

  void changeBorderColor() {
    setState(() {
      borderColor = Colors.red;
    });
    widget.onTap();
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        borderColor = Colors.grey;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: SizedBox(
        width: 140,
        height: 140,
        child: GestureDetector(
          onTap: () {
            changeBorderColor();
          },
          child: Card(
            color: widget.colorLight,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: const BorderSide(
                  color: AppColors.borderColor,
                )),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(widget.imagePath),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  widget.title,
                  style:  montserratBold.copyWith(
                      fontSize: kFont14,
                      color: Colors.white,
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
