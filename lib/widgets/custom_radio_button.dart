import 'package:flutter/material.dart';

import 'package:levels_athletes_coaches/constants/app_colors.dart';

class RoundCheckbox extends StatefulWidget {
  bool value;
  VoidCallback onTap;
  RoundCheckbox({required this.value,required this.onTap,super.key});

  @override
  _RoundCheckboxState createState() => _RoundCheckboxState();
}

class _RoundCheckboxState extends State<RoundCheckbox> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:widget.onTap,
      child: Container(
        width: 24.0,
        height: 24.0,
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: AppColors.primaryColor,
            width: 2.0,
          ),
        ),
        child: widget.value
            ? Container(
          width: 24.0,
          height: 24.0,
          decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primaryColor
          ),
        )
            : null,
      ),
    );
  }
}
