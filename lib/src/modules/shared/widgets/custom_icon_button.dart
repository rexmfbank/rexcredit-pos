import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final double fontSize;
  final String iconPath;
  final Color backgroundColor;
  final Color textColor;

  const CustomIconButton(
      {super.key,
      required this.onPressed,
      required this.title,
      this.fontSize = 12,
      this.iconPath = 'assets/png/plus_icon.png',
      required this.backgroundColor,
      required this.textColor});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: textColor,
        backgroundColor: backgroundColor,
        fixedSize: Size(
          0.90 * screenWidth,
          0.12 * screenWidth,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(iconPath),
          const SizedBox(width: 12),
          Text(title,
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.w500,
              )),
        ],
      ),
    );
  }
}
