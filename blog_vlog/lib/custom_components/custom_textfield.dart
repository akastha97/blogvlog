// Custom class for textfields used in the app

import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String label;
  final String hint;
  final Widget suffix;
  final bool obscure;
  final TextEditingController controller;

  CustomTextField({
    super.key,
    required this.suffix,
    required this.label,
    required this.hint,
    required this.obscure,
    required this.controller,
  });
  

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextField(
       // autocorrect: false,
        textCapitalization:TextCapitalization.none,
        controller: widget.controller,
        obscureText: widget.obscure,
        decoration: InputDecoration(
          suffixIcon: widget.suffix,
          floatingLabelStyle: TextStyle(color: Colors.black),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black, width: 2.0),
            borderRadius: BorderRadius.circular(12.0),
          ),
          border: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black, width: 2.0),
              borderRadius: BorderRadius.circular(12)),
          label: Text(widget.label),
          hintText: widget.hint,
        ),
      ),
    );
  }
}
