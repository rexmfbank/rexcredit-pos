import 'package:flutter/material.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';

class ConnectBankValidationText extends StatelessWidget {
  const ConnectBankValidationText({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: const BoxDecoration(
          color: AppColors.lightGreen,
          borderRadius: BorderRadius.all(
            Radius.circular(16),
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: Row(
          children: const [
            CircleAvatar(
              backgroundColor: Color.fromARGB(255, 41, 99, 73),
              child: Icon(
                Icons.check,
                color: AppColors.rexWhite,
              ),
            ),
            SizedBox(width: 16.0),
            Flexible(
              child: Text(
                'Your salary bank details have been validated',
                style: TextStyle(
                  color: AppColors.rexGreen2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
