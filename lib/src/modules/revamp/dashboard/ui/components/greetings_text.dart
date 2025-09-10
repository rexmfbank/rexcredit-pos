import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/revamp/utils/theme/app_colors.dart';

class GreetingsText extends StatelessWidget {
  const GreetingsText({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Good morning',
            style: TextStyle(color: AppColors.grey),
          ),
          const SizedBox(width: 8.0),
          Image.asset('assets/png/morning_icon.png'),
          // Icon(
          //   Icons.cloud,
          //   color: AppColors.rexPurpleDark,
          // )
        ],
      ),
    );
  }
}
