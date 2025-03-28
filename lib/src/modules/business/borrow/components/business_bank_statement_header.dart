import 'package:flutter/material.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';

class BusinessBankStatementHeader extends StatelessWidget {
  const BusinessBankStatementHeader({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.cardGreen,
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
            backgroundColor: AppColors.rexGreen,
            child: Icon(
              Icons.done,
              color: AppColors.rexWhite,
            ),
          ),
          const SizedBox(width: 10.0),
          Flexible(
            child: Text(text),
          ),
        ],
      ),
    );
  }
}
