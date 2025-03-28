import 'package:flutter/material.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/utils/constants/constants.dart';

class BusinessSetupHeader extends StatelessWidget {
  const BusinessSetupHeader({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.rexWhite,
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
      ),
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(
        right: 14.0,
        bottom: 8.0,
        top: 8.0,
        left: 14.0,
      ),
      child: Row(
        children: [
          const CircleAvatar(
            backgroundColor: AppColors.rexYellow,
            child: Icon(
              Icons.priority_high,
              color: AppColors.rexWhite,
            ),
          ),
          SizedBox(width: 10.aw),
          Flexible(child: Text(text)),
        ],
      ),
    );
  }
}
