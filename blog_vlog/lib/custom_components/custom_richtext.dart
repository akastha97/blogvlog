// Custom class for Rich text used in the app.

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class CustomRichText extends StatefulWidget {
  final String subtext1;
  final String subtext2;
  void Function()? onTap;
  CustomRichText(
      {super.key,
      required this.subtext1,
      required this.subtext2,
      required this.onTap});

  @override
  State<CustomRichText> createState() =>
      _CustomRichTextState(subtext1, subtext2, onTap);
}

class _CustomRichTextState extends State<CustomRichText> {
  final String subtext1;
  final String subtext2;
  void Function()? onTap;

  _CustomRichTextState(this.subtext1, this.subtext2, this.onTap);

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(children: [
      TextSpan(text: subtext1, style: const TextStyle(color: Colors.black)),
      TextSpan(
          recognizer: TapGestureRecognizer()..onTap = onTap,
          text: subtext2,
          style: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold)),
    ]));
  }
}
