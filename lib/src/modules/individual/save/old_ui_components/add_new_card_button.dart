import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/revamp/utils/config/theme/app_colors.dart';

class AddNewCardButton extends StatelessWidget {
  final VoidCallback onPressed;

  const AddNewCardButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return TextButton.icon(
      onPressed: onPressed,
      icon: const Icon(Icons.add),
      label: const Text(
        'Add new card',
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
      style: TextButton.styleFrom(
        foregroundColor: AppColors.rexPurpleDark,
        backgroundColor: AppColors.lightGrey,
        fixedSize: Size(
          0.85 * screenWidth,
          0.12 * screenWidth,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}
