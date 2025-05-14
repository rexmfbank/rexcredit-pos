import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/config/routes/route_name.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/data/rex_api/src/utils/enums/app_menu_type.dart';
import 'package:rex_app/src/modules/individual/dashboard_personal/ui/components/quick_action_card.dart';
import 'package:rex_app/src/modules/individual/dashboard_personal/ui/components/quick_action_tile.dart';
import 'package:rex_app/src/modules/shared/login/providers/login_provider.dart';
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

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.aw),
      child: Column(
        children: [
          QuickActionCard(
            onTap: () {
              !featureEnabledCheck(
                context: context,
                feature: (ref
                            .watch(loginProvider)
                            .loginResponse
                            .value
                            ?.data
                            .appMenu ??
                        [])
                    .firstWhere((element) =>
                        (element.menuCode?.jsonString ?? '') ==
                        AppMenuType.interbank.jsonString),
              )
                  ? null
                  : context.go(Routes.dashboardBorrowBusiness);
            },
            cardBackgroundColor: AppColors.cardPink,
            iconBackgroundColor: AppColors.lightPink,
            titleText: StringAssets.borrowText,
            subtitleText: StringAssets.cardBusinessBorrowSubtitle,
            subtitleColor: const Color(0xff997640),
            quickActionText: StringAssets.applyNow,
            iconPath: AssetPath.businessBorrowIcon,
          ),
          SizedBox(height: 5.ah),
          QuickActionCard(
            onTap: () {
              context.go(Routes.dashboardSaveBusiness);
            },
            cardBackgroundColor: AppColors.cardBlue,
            iconBackgroundColor: AppColors.rexLightBlue2,
            titleText: StringAssets.investText,
            subtitleText: StringAssets.cardInvestTitle,
            quickActionText: StringAssets.investNow,
            iconPath: AssetPath.dSaveIcon,
          ),
          SizedBox(height: 5.ah),
          QuickActionCard(
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
    );

    // return Column(
    //   children: [
    //     Padding(
    //       padding: const EdgeInsets.symmetric(horizontal: 15.0),
    //       child: Row(
    //         mainAxisAlignment: MainAxisAlignment.spaceAround,
    //         children: [
    //           QuickActionCard(
    //             onTap: () {
    //               context.go(RouteName.dashboardBorrowBusiness);
    //             },
    //             cardBackgroundColor: AppColors.cardPink,
    //             iconBackgroundColor: AppColors.lightPink,
    //             titleText: StringAssets.borrowText,
    //             subtitleText: StringAssets.cardBusinessBorrowSubtitle,
    //             subtitleColor: const Color(0xff997640),
    //             quickActionText: 'Apply Now',
    //             iconPath: AssetPath.businessBorrowIcon,
    //           ),
    //           const SizedBox(width: 8.0),
    //           QuickActionCard(
    //             onTap: () {
    //               context.go(RouteName.dashboardSaveBusiness);
    //             },
    //             cardBackgroundColor: AppColors.cardBlue,
    //             iconBackgroundColor: AppColors.rexLightBlue2,
    //             titleText: StringAssets.investText,
    //             subtitleText: 'Let your money earn good returns',
    //             quickActionText: 'Invest Now',
    //             iconPath: AssetPath.dSaveIcon,
    //           ),
    //         ],
    //       ),
    //     ),
    //     const SizedBox(height: 8.0),
    //     Padding(
    //       padding: const EdgeInsets.symmetric(horizontal: 15.0),
    //       child: Row(
    //         mainAxisAlignment: MainAxisAlignment.spaceAround,
    //         children: [
    //           QuickActionCard(
    //             onTap: () {
    //               context.push(
    //                   '${RouteName.dashboardBusiness}/${RouteName.dashboardCashflow}');
    //             },
    //             cardBackgroundColor: const Color(0x1a37D278),
    //             iconBackgroundColor: const Color.fromARGB(111, 55, 210, 120),
    //             titleText: StringAssets.cashflowText,
    //             subtitleText: 'Manage your revenue and income',
    //             quickActionText: 'Start Now',
    //             iconPath: AssetPath.dBusinessCashflowIcon,
    //           ),
    //           const SizedBox(width: 8.0),
    //           QuickActionCard(
    //             onTap: () {
    //               context.push(
    //                   '${RouteName.dashboardBusiness}/${RouteName.dashboardEmployees}');
    //             },
    //             cardBackgroundColor: AppColors.cardBrown,
    //             iconBackgroundColor: const Color(0x80FFA412),
    //             titleText: StringAssets.employeesText,
    //             subtitleText: StringAssets.employeesSubtitle,
    //             subtitleColor: const Color(0xff997640),
    //             quickActionText: 'View Now',
    //             iconPath: AssetPath.businessEmployeesIcon,
    //           ),
    //         ],
    //       ),
    //     ),
    //   ],
    // );
  }
}
