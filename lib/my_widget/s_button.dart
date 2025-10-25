import 'package:flutter/material.dart';

import '../contants/colors.dart';

class SButton extends StatelessWidget {
  final String? text;
  final Color? color;
  final Color? textColor;
  const SButton({super.key, required this.text, this.color, this.textColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
      decoration: BoxDecoration(
        color: color ?? AppColors.yellow,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        text.toString(),
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: textColor ?? AppColors.primary,
          decoration: TextDecoration.none,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
