import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/config/routes/route_name.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/individual/dashboard_personal/ui/components/quick_action_card.dart';
import 'package:rex_app/src/utils/constants/asset_path.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class DashboardCashflowActions extends HookConsumerWidget {
  const DashboardCashflowActions({super.key});
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
              QuickActionCard(
                onTap: () {
                  context.push(
                      '${Routes.dashboardBusiness}/${Routes.cashflowInvoice}');
                },
                cardBackgroundColor: AppColors.cardGreen,
                iconBackgroundColor: AppColors.rexGreen,
                titleText: 'Invoice',
                subtitleText: 'View and create invoice for clients',
                subtitleColor: AppColors.rexGreen2,
                quickActionText: 'View',
                iconPath: 'assets/png/receipt_icon.png',
              ),
              const SizedBox(width: 8.0),
              QuickActionCard(
                onTap: () {
                  context.push(
                      '${Routes.dashboardBusiness}/${Routes.cashflowReceipt}');
                },
                cardBackgroundColor: AppColors.cardBrown,
                iconBackgroundColor: AppColors.rexBrown,
                titleText: 'Receipts',
                subtitleText: 'View and create receipt for clients',
                quickActionText: 'View',
                iconPath: 'assets/png/receipt_icon.png',
              ),
            ],
          ),
        ),
        const SizedBox(height: 8.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              QuickActionCard(
                onTap: () {
                  context.push(
                      '${Routes.dashboardBusiness}/${Routes.cashflowInventory}');
                },
                cardBackgroundColor: AppColors.cardBlue,
                iconBackgroundColor: AppColors.rexWhite,
                titleText: 'Inventory',
                subtitleText: StringAssets.cardSpendTitle,
                quickActionText: 'Create Now',
                iconPath: AssetPath.dSpendIcon,
              ),
              const SizedBox(width: 8.0),
              QuickActionCard(
                onTap: () {
                  context.push(
                      '${Routes.dashboardBusiness}/${Routes.cashflowPayments}');
                },
                cardBackgroundColor: AppColors.cardPink,
                iconBackgroundColor: const Color.fromARGB(180, 240, 167, 154),
                titleText: 'Payments',
                subtitleText: 'Generate a payment link            __',
                subtitleColor: const Color.fromARGB(255, 203, 100, 81),
                quickActionText: 'Create Link',
                iconPath: 'assets/png/payment_link_icon.png',
              ),
            ],
          ),
        ),
      ],
    );
  }
}
