import 'package:flutter/material.dart';

class SavingsDialogButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final double fontSize;
  final bool hasIcon;
  final Color backgroundColor;
  final Color textColor;

  const SavingsDialogButton(
      {super.key,
      required this.onPressed,
      required this.title,
      this.fontSize = 12,
      this.hasIcon = true,
      required this.backgroundColor,
      required this.textColor});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return TextButton.icon(
      onPressed: onPressed,
      icon: hasIcon ? const Icon(Icons.add) : Container(),
      label: Text(
        title,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.w500,
        ),
      ),
      style: TextButton.styleFrom(
        foregroundColor: textColor,
        backgroundColor: backgroundColor,
        fixedSize: Size(
          0.85 * screenWidth,
          0.12 * screenWidth,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}
