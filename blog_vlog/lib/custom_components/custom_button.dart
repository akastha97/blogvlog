// Custom class for buttons used in the app

import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  final String buttonText;
  Function()? onPressed;
  CustomButton({super.key, required this.buttonText, required this.onPressed});

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      width: 140,
      child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
          ),
          onPressed: () => widget.onPressed?.call(),
          child: Text(
            "${widget.buttonText}",
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white),
          )),
    );
  }
}
