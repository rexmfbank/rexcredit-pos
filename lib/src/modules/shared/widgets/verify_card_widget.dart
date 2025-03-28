import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_elevated_button.dart';

class VerifyCardWidget extends StatelessWidget {
  const VerifyCardWidget({
    super.key,
    required this.assetPath,
    required this.text,
    required this.onPressed,
    required this.buttonTitle,
  });

  final String assetPath;
  final String text;
  final void Function()? onPressed;
  final String? buttonTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 200,
          child: LottieBuilder.asset(assetPath),
        ),
        Align(
          alignment: Alignment.center,
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 16,
              color: AppColors.rexPurpleDark,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 12.0),
        buttonTitle == null || onPressed == null
            ? Container()
            : Align(
                alignment: Alignment.center,
                child: RexElevatedButton(
                  onPressed: onPressed,
                  buttonTitle: buttonTitle!,
                  backgroundColor: null,
                ),
              ),
      ],
    );
  }
}
