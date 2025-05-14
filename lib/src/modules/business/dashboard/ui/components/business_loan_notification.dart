import 'package:flutter/material.dart';
import 'package:rex_app/src/config/routes/route_name.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/utils/constants/asset_path.dart';
import 'package:go_router/go_router.dart';

class BusinessLoanNotification extends StatelessWidget {
  const BusinessLoanNotification({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(
          "${Routes.dashboardBusiness}/${Routes.businessLoanOffer}",
        );
      },
      child: Container(
        decoration: const BoxDecoration(
          color: AppColors.cardBlue,
          borderRadius: BorderRadius.all(
            Radius.circular(16),
          ),
        ),
        margin: const EdgeInsets.only(
          left: 16.0,
          right: 16.0,
          bottom: 12.0,
        ),
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Expanded(
              child: Image.asset(
                AssetPath.imageLoanApply,
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Loan Application',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.rexBlue,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Your requested loan amount of ₦50,000 has been approved',
                    style: TextStyle(
                      color: AppColors.rexBlue,
                    ),
                  ),
                ],
              ),
            ),
            const Expanded(
              child: Icon(Icons.navigate_next),
            ),
          ],
        ),
      ),
    );
  }
}
