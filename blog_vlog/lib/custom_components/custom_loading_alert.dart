import 'package:flutter/material.dart';

class CustomLoadingAlert extends StatelessWidget {
  const CustomLoadingAlert({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content:  CircularProgressIndicator(),
    );
  }
}
