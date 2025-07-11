import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/utils/config/routes/route_name.dart';
import 'package:rex_app/src/modules/revamp/utils/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/revamp/dashboard_personal/ui/components/quick_action_tile.dart';

import 'package:rex_app/src/utils/constants/asset_path.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';
import 'package:rex_app/src/utils/mixin/app_actions_mixin.dart';

class DashboardBusinessQuickActions extends HookConsumerWidget
    with AppActionsMixin {
  const DashboardBusinessQuickActions({super.key});

  final bool isProfileCompleted = false;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // QuickActionTile(
              //   onTap: () => context.push(RouteName.dashboardSave),
              //   cardBackgroundColor: AppColors.rexYellow.withOpacity(0.3),
              //   iconBackgroundColor: AppColors.rexWhite,
              //   titleText: StringAssets.saveText,
              //   subtitleText: StringAssets.cardSaveTitle,
              //   quickActionText: StringAssets.startText,
              //   iconPath: AssetPath.dSaveIcon,
              // ),
              QuickActionTile(
                onTap: () => context.push(
                    '${Routes.dashboardBusiness}/${Routes.dashboardEmployees}'),
                cardBackgroundColor: AppColors.rexYellow.withOpacity(0.3),
                iconBackgroundColor: AppColors.rexWhite,
                titleText: StringAssets.employeesText,
                subtitleText: StringAssets.employeesSubtitle,
                quickActionText: StringAssets.viewNow,
                iconPath: AssetPath.businessEmployeesIcon,
              ),
              SizedBox(width: 8.0.aw),
              QuickActionTile(
                onTap: () => context.push(
                  Routes.dashboardSave,
                  extra: 1,
                ),
                cardBackgroundColor: AppColors.cardBlue,
                iconBackgroundColor: AppColors.rexLightBlue2,
                titleText: StringAssets.investText,
                subtitleText: StringAssets.cardInvestTitle,
                quickActionText: StringAssets.investNow,
                iconPath: AssetPath.dSaveIcon,
              ),
            ],
          ),
        ),
        SizedBox(height: 8.ah),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              QuickActionTile(
                onTap: () => context.push(Routes.dashboardSpend),
                cardBackgroundColor: AppColors.cardPink,
                iconBackgroundColor: AppColors.rexWhite,
                titleText: StringAssets.spendText,
                subtitleText: StringAssets.cardSpendTitle,
                quickActionText: StringAssets.payNowText,
                iconPath: AssetPath.dSpendIcon,
              ),
              SizedBox(width: 8.0.aw),
              // QuickActionTile(
              //   onTap: () {
              //     context.push(
              //         "${RouteName.dashboardMoreBusiness}/${RouteName.cards}");
              //   },
              //   cardBackgroundColor: AppColors.rexGreen2.withOpacity(0.4),
              //   iconBackgroundColor: AppColors.rexWhite,
              //   titleText: StringAssets.cards,
              //   subtitleText: StringAssets.requestCardSubtitle,
              //   quickActionText: StringAssets.requestNow,
              //   iconPath: AssetPath.dSpendIcon,
              // ),
              QuickActionTile(
                onTap: () {
                  context.push(
                      '${Routes.dashboardBusiness}/${Routes.cashflowInventory}');
                },
                cardBackgroundColor: AppColors.rexGreen2.withOpacity(0.4),
                iconBackgroundColor: AppColors.rexWhite,
                titleText: StringAssets.inventory,
                subtitleText: StringAssets.cardInventoryTitle,
                quickActionText: StringAssets.createNow,
                iconPath: AssetPath.dSpendIcon,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
