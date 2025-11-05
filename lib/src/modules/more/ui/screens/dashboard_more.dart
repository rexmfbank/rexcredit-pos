import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/utils/routes/route_name.dart';
import 'package:rex_app/src/modules/revamp/utils/theme/app_colors.dart';
import 'package:rex_app/src/modules/revamp/dashboard/providers/dashboard_providers.dart';
import 'package:rex_app/src/modules/more/ui/components/dashboard_more_appbar.dart';
import 'package:rex_app/src/modules/revamp/login/ui/components/app_version_text.dart';
import 'package:rex_app/src/modules/revamp/pos_device/notifier/pos_global_notifier.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_list_tile.dart';
import 'package:rex_app/src/utils/constants/asset_path.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';
import 'package:go_router/go_router.dart';

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
            title: Strings.profileTitle,
            subtitle: Strings.profileSubtitle,
            hasTrailingIcon: true,
            onTap: () {
              context.push("${Routes.dashboardMore}/${Routes.profile}");
            },
          ),
          RexListTile(
            leadingWidget: Icon(Icons.key, color: AppColors.rexBlue),
            title: "Key Exchange",
            subtitle: "Perform a key exchange process",
            //subtitle: ref.watch(baseAppNameProvider),
            hasTrailingIcon: true,
            onTap: () async {
              ref
                  .read(posGlobalProvider.notifier)
                  .doKeyExchange(context: context);
            },
          ),
          RexListTile(
            leadingWidget: Icon(Icons.print, color: AppColors.rexBlue),
            title: 'Printing Check',
            subtitle: "Test printer",
            //subtitle: "Image path ${ref.watch(printingImageProvider)}",
            hasTrailingIcon: true,
            onTap: () async {
              ref.read(posGlobalProvider.notifier).doPrintingTest(context);
            },
          ),
          RexListTile(
            leadingWidget: Image.asset(AssetPath.moreRequestCardIcon),
            title: Strings.bankStatementTitle,
            subtitle: Strings.bankStatementSubtitle,
            hasTrailingIcon: true,
            onTap: () {
              context.push(
                "${Routes.dashboardMore}/${Routes.indRequestStatement}",
              );
            },
          ),
          RexListTile(
            leadingWidget: Image.asset(AssetPath.moreLegalIcon),
            title: Strings.legalTitle,
            subtitle: Strings.legalSubtitle,
            hasTrailingIcon: true,
            onTap: () {
              context.push("${Routes.dashboardMore}/${Routes.legal}");
            },
          ),
          RexListTile(
            leadingWidget: Image.asset(AssetPath.moreQuestionIcon),
            title: Strings.faqTitle,
            subtitle: Strings.faqSubtitle,
            hasTrailingIcon: true,
            onTap: () {
              context.push("${Routes.dashboardMore}/${Routes.faq}");
            },
          ),
          RexListTile(
            leadingWidget: Image.asset(AssetPath.moreLogoutIcon),
            title: Strings.logoutTitle,
            subtitle: null,
            hasTrailingIcon: true,
            titleTextColor: AppColors.red,
            onTap: () {
              context.go(Routes.homeScreen);
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
