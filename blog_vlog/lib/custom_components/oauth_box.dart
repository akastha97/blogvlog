import 'package:flutter/material.dart';

class OuathBox extends StatefulWidget {
  final Function()? onclick;
  final Widget child;
   
  OuathBox({super.key, required this.child, required this.onclick});

  @override
  State<OuathBox> createState() => _OuathBoxState();
}

class _OuathBoxState extends State<OuathBox> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: GestureDetector(
        onTap: widget.onclick,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(10),
          ),
          height: 60,
          width: 60,
          child: widget.child,
        ),
      ),
    );
  }
}
