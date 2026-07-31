import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/utils/general/constants.dart';
import 'package:rex_app/src/modules/utils/theme/app_colors.dart';

class LoginNewHeader extends StatelessWidget {
  const LoginNewHeader({super.key, this.subtitle = 'Sign in to your terminal'});

  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.aw),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Login',
            style: TextStyle(
              fontSize: 28.asp,
              fontWeight: FontWeight.w700,
              color: AppColors.rexPurpleDark,
            ),
          ),
          SizedBox(height: 6.ah),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 14.asp,
              fontWeight: FontWeight.w600,
              color: AppColors.rexTint1000,
            ),
          ),
        ],
      ),
    );
  }
}
