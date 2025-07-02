import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rex_app/src/modules/revamp/utils/config/theme/app_colors.dart';

class TransferToRexAccountCard extends StatelessWidget {
  const TransferToRexAccountCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.rexTint300,
        ),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 24,
          top: 22,
          right: 24,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Transfer to Rex Account",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.rexPurpleDark,
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    await Clipboard.setData(
                            const ClipboardData(text: "Account Number"))
                        .then((_) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Account Number copied to clipboard")));
                    });
                  },
                  child: Icon(
                    Icons.copy_rounded,
                    size: 18,
                    color: AppColors.rexTint500,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 26.0),
              child: Text(
                "SLS MFB \n 0000417501",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                  color: AppColors.rexTint500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
