import 'package:flutter/material.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/utils/constants/asset_path.dart';

class BusinessLoanExplanationHeader extends StatelessWidget {
  const BusinessLoanExplanationHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.cardBlue,
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
          CircleAvatar(
            backgroundColor: Colors.transparent,
            child: Image.asset(AssetPath.imagePin),
          ),
          const SizedBox(width: 10.0),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Working Capital',
                  style: TextStyle(
                    color: AppColors.rexPurpleDark,
                  ),
                ),
                SizedBox(height: 4.0),
                Flexible(
                  child: Text(
                      "A working capital loan is a loan taken to finance a company's everyday operations."),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
