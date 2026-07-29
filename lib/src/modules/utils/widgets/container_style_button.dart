import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/utils/general/constants.dart';

class ContainerStyleButton extends StatelessWidget {
  const ContainerStyleButton({
    super.key,
    required this.title,
    required this.bgColor,
    required this.textColor,
    required this.onTap,
    this.border,
    this.btnWidth,
    this.btnHeight,
  });

  final String title;
  final Color bgColor;
  final Color textColor;
  final VoidCallback? onTap;
  final BoxBorder? border;
  final double? btnWidth;
  final double? btnHeight;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: btnHeight ?? 85.ah,
        width: btnWidth,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(10),
          border: border,
        ),
        child: Align(
          alignment: Alignment.center,
          child: Text(
            title,
            style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
