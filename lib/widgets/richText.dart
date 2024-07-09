import 'package:flutter/material.dart';
import 'package:levels_athletes_coaches/constants/app_text_styles.dart';

RichText richText(String title, String text) {
  return RichText(
    maxLines: 2,
    overflow: TextOverflow.ellipsis,
    text: TextSpan(
      children: <TextSpan>[
        TextSpan(
            text: title,
            style: montserratSemiBold.copyWith(
              fontSize: 14,
                fontWeight: FontWeight.bold, color: Colors.red)),
        TextSpan(
          text: text,
          style: montserratRegular.copyWith(color: Colors.white,fontSize: 14),
        ),
      ],
    ),
  );
}
