import 'package:flutter/material.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';

class PasswordCheck extends StatelessWidget {
  const PasswordCheck({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 8, bottom: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Password must contain',
            style: passswordCheckStyle,
          ),
          const SizedBox(height: 4.0),
          Wrap(
            spacing: 8.0,
            children: [
              Chip(
                label: Text('Minimum 8 characters', style: passswordCheckStyle),
                backgroundColor: AppColors.lightBlue,
              ),
              Chip(
                label: Text('Lower case', style: passswordCheckStyle),
                backgroundColor: AppColors.lightBlue,
              ),
              Chip(
                label: Text('Digit', style: passswordCheckStyle),
                backgroundColor: AppColors.lightBlue,
              ),
              Chip(
                label: Text('Upper case', style: passswordCheckStyle),
                backgroundColor: AppColors.lightBlue,
              ),
              Chip(
                label: Text('Special character', style: passswordCheckStyle),
                backgroundColor: AppColors.lightBlue,
              ),
            ],
          )
        ],
      ),
    );
  }
}

final passswordCheckStyle = TextStyle(color: AppColors.rexPurpleLight);
