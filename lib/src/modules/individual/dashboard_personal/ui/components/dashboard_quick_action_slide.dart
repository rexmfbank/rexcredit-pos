import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/config/routes/route_name.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/individual/dashboard_personal/ui/components/quick_action_tile.dart';
import 'package:rex_app/src/utils/constants/asset_path.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class DashboardQuickActionSlide extends StatelessWidget {
  const DashboardQuickActionSlide({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.aw),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              QuickActionTile(
                onTap: () {
                  context.push(
                      "${RouteName.dashboardIndividual}/${RouteName.purchaseScreen}");
                },
                cardBackgroundColor: AppColors.cardBrown,
                iconBackgroundColor: AppColors.rexWhite,
                titleText: "Purchase",
                subtitleText: "Make purchases with a Credit/Debit card",
                quickActionText: "Pay now",
                iconPath: AssetPath.dSpendIcon,
              ),
              SizedBox(width: 8.aw),
              QuickActionTile(
                onTap: () => context.go(RouteName.dashboardSave),
                cardBackgroundColor: AppColors.cardGreen,
                iconBackgroundColor: AppColors.rexWhite,
                titleText: StringAssets.saveText,
                subtitleText: StringAssets.cardSaveTitle,
                quickActionText: StringAssets.startText,
                iconPath: AssetPath.dSaveIcon,
              ),
            ],
          ),
        ),
        SizedBox(height: 8.ah),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                QuickActionTile(
                  onTap: () {
                    context.push(
                        "${RouteName.dashboardIndividual}/${RouteName.reprintScreen}");
                  },
                  cardBackgroundColor: AppColors.cardPink,
                  iconBackgroundColor: AppColors.rexWhite,
                  titleText: "Receipt",
                  subtitleText: "Print transaction receipt",
                  quickActionText: "Print now",
                  iconPath: AssetPath.dSpendIcon,
                ),
                SizedBox(width: 8.aw),
                QuickActionTile(
                  onTap: () => context.go(
                    RouteName.dashboardSave,
                    extra: 1,
                  ),
                  cardBackgroundColor: AppColors.cardBlue,
                  iconBackgroundColor: AppColors.rexWhite,
                  titleText: StringAssets.investText,
                  subtitleText: StringAssets.cardInvestTitle,
                  quickActionText: StringAssets.investNow,
                  iconPath: AssetPath.dInvestIcon,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
