import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/config/routes/route_name.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/individual/dashboard_personal/providers/dashboard_providers.dart';
import 'package:rex_app/src/modules/individual/more/ui/components/dashboard_more_appbar.dart';
import 'package:rex_app/src/modules/individual/more/ui/components/show_deactivate_modal.dart';
import 'package:rex_app/src/modules/shared/login/ui/components/app_version_text.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_list_tile.dart';
import 'package:rex_app/src/utils/constants/asset_path.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';
import 'package:rex_app/src/utils/service/secure_storage.dart';

class DashboardBusinessMore extends ConsumerWidget {
  const DashboardBusinessMore({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const DashboardMoreAppBar(),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          RexListTile(
            leadingWidget: Image.asset(AssetPath.moreRequestCardIcon),
            title: StringAssets.requestCard,
            subtitle: StringAssets.requestCardSubtitle,
            hasTrailingIcon: true,
            onTap: () {
              context.push(
                "${Routes.dashboardMoreBusiness}/${Routes.cards}",
              );
            },
          ),
          RexListTile(
            leadingWidget: Image.asset(AssetPath.moreRequestCardIcon),
            title: StringAssets.bankStatementTitle,
            subtitle: StringAssets.bankStatementSubtitle,
            hasTrailingIcon: true,
            onTap: () {
              context.push(
                "${Routes.dashboardMoreBusiness}/${Routes.bizRequestStatement}",
              );
            },
          ),
          RexListTile(
            visible: true,
            leadingWidget: Image.asset(AssetPath.moreRequestPOSIcon),
            title: StringAssets.requestPos,
            subtitle: StringAssets.requestPosSubtitle,
            hasTrailingIcon: true,
            onTap: () {
              context
                  .push('${Routes.dashboardMoreBusiness}/${Routes.requestPos}');
            },
          ),
          RexListTile(
            visible: false,
            leadingWidget: Image.asset(AssetPath.moreAuditLogsIcon),
            title: StringAssets.auditLog,
            subtitle: StringAssets.auditLogSubtitle,
            hasTrailingIcon: true,
            onTap: () {
              context.push(
                "${Routes.dashboardMoreBusiness}/${Routes.auditLogs}",
              );
            },
          ),
          RexListTile(
            visible: false,
            leadingWidget: Image.asset(AssetPath.moreUserManagementIcon),
            title: StringAssets.userManagement,
            subtitle: StringAssets.userManagementSubtitle,
            hasTrailingIcon: true,
            onTap: () {
              context.push(
                "${Routes.dashboardMoreBusiness}/${Routes.businessUserManagement}",
              );
            },
          ),
          RexListTile(
            leadingWidget: Image.asset(AssetPath.moreBusinessProfileIcon),
            title: StringAssets.businessProfile,
            subtitle: StringAssets.businessProfileSub,
            hasTrailingIcon: true,
            onTap: () {
              context.push(
                "${Routes.dashboardMoreBusiness}/${Routes.businessProfile}",
              );
            },
          ),
          RexListTile(
            visible: false,
            leadingWidget: Image.asset(AssetPath.moreBusinessRegIcon),
            title: StringAssets.businessRegistration,
            subtitle: StringAssets.businessRegistrationSubtitle,
            hasTrailingIcon: true,
          ),
          const SizedBox(height: 12),
          Padding(
            padding: EdgeInsets.all(8.ar),
            child: Text(
              StringAssets.general,
              style: TextStyle(
                fontSize: 18.asp,
                fontWeight: FontWeight.bold,
                color: AppColors.rexPurpleDark,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.aw),
            child: Text(
              StringAssets.moreRexActions,
              style: TextStyle(
                fontSize: 12.asp,
                fontWeight: FontWeight.w400,
                color: AppColors.rexPurpleDark,
              ),
            ),
          ),
          const SizedBox(height: 12),
          RexListTile(
            leadingWidget: Image.asset(AssetPath.moreSupportIcon),
            title: StringAssets.supportTitle,
            subtitle: StringAssets.supportSubtitle,
            hasTrailingIcon: true,
            onTap: () {
              context.push(
                "${Routes.dashboardMoreBusiness}/${Routes.support}",
              );
            },
          ),
          RexListTile(
            leadingWidget: Image.asset(AssetPath.moreLegalIcon),
            title: StringAssets.legalTitle,
            subtitle: StringAssets.legalSubtitle,
            hasTrailingIcon: true,
            onTap: () {
              context.push(
                "${Routes.dashboardMoreBusiness}/${Routes.termsAndConditions}",
              );
            },
          ),
          RexListTile(
            leadingWidget: Image.asset(AssetPath.moreQuestionIcon),
            title: StringAssets.faqTitle,
            subtitle: StringAssets.faqSubtitle,
            hasTrailingIcon: true,
            onTap: () {
              context.push(
                "${Routes.dashboardMoreBusiness}/${Routes.buisnessFaq}",
              );
            },
          ),
          RexListTile(
            leadingWidget: Image.asset(AssetPath.moreProfileIcon),
            title: StringAssets.referralTitle,
            subtitle: StringAssets.earnOnRex,
            hasTrailingIcon: true,
            onTap: () {
              context.push(
                "${Routes.dashboardMoreBusiness}/${Routes.referral}",
              );
            },
          ),
          RexListTile(
            leadingWidget: Image.asset(AssetPath.profileDeleteIcon),
            title: StringAssets.deactivateAcct,
            subtitle: null,
            hasTrailingIcon: true,
            onTap: () {
              showDeactivateModal(context: context);
            },
          ),
          RexListTile(
            leadingWidget: Image.asset(AssetPath.moreLogoutIcon),
            title: StringAssets.logoutTitle,
            subtitle: null,
            hasTrailingIcon: true,
            titleTextColor: Colors.red,
            onTap: () {
              context.go(Routes.login);
              SecureStorage().setLaunchStateVal('LO');
              ref.invalidate(dashboardHomePageViewIndexProvider);
            },
          ),
          SizedBox(height: 30.ah),
          const AppVersionText(),
          SizedBox(height: 30.ah),
        ],
      ),
    );
  }
}
