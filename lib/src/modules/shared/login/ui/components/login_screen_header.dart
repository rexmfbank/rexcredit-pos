import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class LoginScreenHeader extends StatelessWidget {
  const LoginScreenHeader({super.key});

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
              StringAssets.loginUserTitle2,
              style: TextStyle(
                color: AppColors.rexPurpleLight,
                fontWeight: FontWeight.w700,
                fontSize: 25,
              ),
            ),
          ),
        ),
        const Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 16.0),
            child: Text(StringAssets.loginUserTitle3),
          ),
        ),
        SizedBox(
          height: 200,
          child: Lottie.asset('assets/lottiefiles/login.json'),
        ),
      ],
    );
  }
}
