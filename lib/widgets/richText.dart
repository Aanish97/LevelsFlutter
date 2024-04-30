import 'package:flutter/material.dart';

RichText richText(String title, String text) {
  return RichText(
    text: TextSpan(
      children: <TextSpan>[
        TextSpan(
            text: title,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.red)),
        TextSpan(text: text, style: const TextStyle(color: Colors.white)),
      ],
    ),
  );
}
