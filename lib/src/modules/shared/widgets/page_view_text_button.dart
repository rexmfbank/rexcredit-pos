import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/revamp/utils/config/theme/app_colors.dart';

class PageViewTextButton extends StatelessWidget {
  const PageViewTextButton({
    super.key,
    required this.textOnButton,
    required this.pageController,
    required this.onPressed,
    this.backgroundColor,
    this.shape,
  });

  final String textOnButton;
  final PageController pageController;
  final Color? backgroundColor;
  final OutlinedBorder? shape;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.rexPurpleDark,
        backgroundColor: backgroundColor,
        shape: shape,
      ),
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Text(textOnButton),
      ),
    );
  }
}

final roundRectBorder = RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(14),
);

const duration300ms = Duration(milliseconds: 300);

const easeInCurve = Curves.easeIn;
