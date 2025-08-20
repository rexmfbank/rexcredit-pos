import 'package:flutter/material.dart';

class AppPrimaryButton extends StatelessWidget {
  final String text;
  final TextStyle? textStyle;
  final bool isLoading;
  final Function()? onClick;
  final bool enabled;
  final Color color;
  final Color textColor;

  const AppPrimaryButton({
    super.key,
    this.isLoading = false,
    required this.text,
    this.textStyle,
    this.color = const Color(0xFF02592D),
    this.onClick,
    this.textColor = const Color(0xFFFFFFFF),
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed:
          isLoading
              ? null
              : enabled
              ? onClick
              : null,
      color: color,
      disabledColor: color.withValues(alpha: 0.5),
      minWidth: double.infinity,
      height: 56,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child:
          isLoading
              ? const SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(),
              )
              : Text(text, style: textStyle ?? TextStyle(color: textColor)),
    );
  }
}
