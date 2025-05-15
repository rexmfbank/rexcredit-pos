import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/config/routes/route_name.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/individual/dashboard_personal/providers/dashboard_providers.dart';
import 'package:rex_app/src/modules/individual/more/ui/components/dashboard_more_appbar.dart';
import 'package:rex_app/src/modules/individual/more/ui/components/show_deactivate_modal.dart';
import 'package:rex_app/src/modules/shared/login/ui/components/app_version_text.dart';
import 'package:rex_app/src/modules/shared/pos_device/pos_type_notifier.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_list_tile.dart';
import 'package:rex_app/src/utils/constants/asset_path.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';
import 'package:go_router/go_router.dart';
import 'package:rex_app/src/utils/service/secure_storage.dart';

class DashboardMore extends ConsumerWidget {
  const DashboardMore({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const DashboardMoreAppBar(),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          RexListTile(
            leadingWidget: Image.asset(AssetPath.moreProfileIcon),
            title: StringAssets.profileTitle,
            subtitle: StringAssets.profileSubtitle,
            hasTrailingIcon: true,
            onTap: () {
              context.push(
                "${Routes.dashboardMore}/${Routes.profile}",
              );
            },
          ),
          RexListTile(
            leadingWidget: Image.asset(AssetPath.moreProfileIcon),
            title: StringAssets.updateTitle,
            subtitle: StringAssets.updateSubtitle,
            hasTrailingIcon: true,
            onTap: () {
              context.push(
                "${Routes.dashboardMore}/${Routes.updateAccount}",
              );
            },
          ),
          RexListTile(
            leadingWidget: Icon(
              Icons.key,
              color: AppColors.rexBlue,
            ),
            title: "Key Exchange",
            subtitle: "Perform a key exchange process",
            hasTrailingIcon: true,
            onTap: () async {
              ref.read(posTypeProvider.notifier).doKeyExchange();
            },
          ),
          RexListTile(
            leadingWidget: Icon(Icons.print, color: AppColors.rexBlue),
            title: 'Printing Check',
            subtitle: "Test printer",
            hasTrailingIcon: true,
            onTap: () async {
              ref.read(posTypeProvider.notifier).doPrintingTest(context);
            },
          ),
          /*RexListTile(
            leadingWidget: Image.asset(AssetPath.moreRequestCardIcon),
            title: StringAssets.requestCard,
            subtitle: StringAssets.requestCardSubtitle,
            hasTrailingIcon: true,
            onTap: () {
              context.push(
                "${RouteName.dashboardMoreBusiness}/${RouteName.cards}",
              );
            },
          ),*/
          RexListTile(
            leadingWidget: Image.asset(AssetPath.moreRequestCardIcon),
            title: StringAssets.bankStatementTitle,
            subtitle: StringAssets.bankStatementSubtitle,
            hasTrailingIcon: true,
            onTap: () {
              context.push(
                "${Routes.dashboardMore}/${Routes.indRequestStatement}",
              );
            },
          ),
          RexListTile(
            visible: false,
            leadingWidget: Image.asset(AssetPath.moreRequestPOSIcon),
            title: StringAssets.requestPos,
            subtitle: StringAssets.requestPosSubtitle,
            hasTrailingIcon: true,
            onTap: () {
              context.push('${Routes.dashboardMore}/${Routes.requestPos}');
            },
          ),
          RexListTile(
            leadingWidget: Image.asset(AssetPath.moreSupportIcon),
            title: StringAssets.supportTitle,
            subtitle: StringAssets.supportSubtitle,
            hasTrailingIcon: true,
            onTap: () {
              context.push(
                "${Routes.dashboardMore}/${Routes.support}",
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
                "${Routes.dashboardMore}/${Routes.legal}",
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
                "${Routes.dashboardMore}/${Routes.faq}",
              );
            },
          ),
          RexListTile(
            leadingWidget: Image.asset(AssetPath.moreProfileIcon),
            title: StringAssets.referralTitle,
            subtitle: StringAssets.referralSubtitle,
            hasTrailingIcon: true,
            onTap: () {
              context.push(
                "${Routes.dashboardMore}/${Routes.individualReferral}",
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
            titleTextColor: AppColors.red,
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
