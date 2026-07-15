import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/home/widget/app_version_text.dart';
import 'package:rex_app/src/modules/login/provider/login_provider.dart';
import 'package:rex_app/src/modules/more/widgets/dashboard_more_appbar.dart';
import 'package:rex_app/src/modules/pos_device/notifier/pos_global_notifier.dart';
import 'package:rex_app/src/modules/utils/routes/route_name.dart';
import 'package:rex_app/src/modules/utils/theme/app_colors.dart';
import 'package:rex_app/src/modules/utils/widgets/rex_list_tile.dart';
import 'package:rex_app/src/modules/utils/general/asset_path.dart';
import 'package:rex_app/src/modules/utils/general/constants.dart';
import 'package:rex_app/src/modules/utils/general/app_strings.dart';

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
              //context.push("${Routes.dashboardMore}/${Routes.profile}");
              context.push("${Routes.dashboardMore}/${Routes.personalProfile}");
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
