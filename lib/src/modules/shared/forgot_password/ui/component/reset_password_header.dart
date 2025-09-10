import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:rex_app/src/modules/revamp/utils/theme/app_colors.dart';

class ResetPasswordHeader extends StatelessWidget {
  const ResetPasswordHeader({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 16.0),
            child: Text(
              'Reset password',
              style: TextStyle(
                color: AppColors.rexPurpleLight,
                fontWeight: FontWeight.w700,
                fontSize: 25,
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(text),
          ),
        ),
        SizedBox(
          height: 200,
          child: Lottie.asset('assets/lottiefiles/password_lock.json'),
        ),
      ],
    );
  }
}
