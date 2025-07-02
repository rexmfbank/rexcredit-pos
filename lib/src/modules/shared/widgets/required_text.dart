import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/revamp/utils/config/theme/app_colors.dart';

class RequiredText extends StatelessWidget {
  const RequiredText({
    super.key,
    required this.title,
    this.isRequired = true,
  });

  final String title;
  final bool? isRequired;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(children: [
        TextSpan(
          text: title,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 15,
            color: AppColors.rexBlack,
            height: 1.5,
          ),
        ),
        isRequired!
            ? const TextSpan(
                text: ' *',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  color: AppColors.rexError,
                  height: 1.5,
                ),
              )
            : const TextSpan(text: ''),
      ]),
    );
  }
}
