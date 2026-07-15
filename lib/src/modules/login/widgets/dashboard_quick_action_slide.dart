import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rex_app/src/modules/login/widgets/quick_action_tile.dart';
import 'package:rex_app/src/modules/utils/routes/route_name.dart';

import 'package:rex_app/src/modules/utils/theme/app_colors.dart';
import 'package:rex_app/src/modules/utils/general/asset_path.dart';

class DashboardQuickActionSlide extends StatelessWidget {
  const DashboardQuickActionSlide({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              QuickActionTile(
                onTap: () {
                  context.push(
                    "${Routes.dashboardHome}/${Routes.purchaseScreen}",
                  );
                },
                cardBackgroundColor: AppColors.cardBrown,
                iconBackgroundColor: AppColors.rexWhite,
                titleText: "Purchase",
                subtitleText: "Make purchases with a Credit/Debit card",
                quickActionText: "Pay now",
                iconPath: AssetPath.dSpendIcon,
              ),
              QuickActionTile(
                onTap: () {
                  context.push(
                    "${Routes.dashboardHome}/${Routes.reprintScreen}",
                  );
                },
                cardBackgroundColor: AppColors.cardPink,
                iconBackgroundColor: AppColors.rexWhite,
                titleText: "Receipt",
                subtitleText: "Print transaction receipt",
                quickActionText: "Print now",
                iconPath: AssetPath.dSpendIcon,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
