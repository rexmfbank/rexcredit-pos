import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/utils/routes/route_name.dart';
import 'package:rex_app/src/modules/revamp/newProfile/provider/reset_transaction_pin_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_list_tile.dart';
import 'package:rex_app/src/utils/constants/asset_path.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class SecuritySlide extends ConsumerWidget {
  const SecuritySlide({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        RexListTile(
          leadingWidget: Image.asset(AssetPath.securitySafeIcon),
          title: Strings.changePassword,
          subtitle: Strings.changePasswordSubtext,
          hasTrailingIcon: true,
          onTap: () {
            context.go("${Routes.dashboardMore}/${Routes.changepassword}");
          },
        ),
        // RexListTile(
        //   leadingWidget: Image.asset(AssetPath.securityLockIcon),
        //   title: StringAssets.changeTranPin,
        //   subtitle: StringAssets.changeTranPinSubText,
        //   hasTrailingIcon: true,
        //   onTap: () {
        //     context.go(
        //       "${Routes.dashboardMore}/${Routes.enterOldPin}",
        //     );
        //   },
        // ),
        RexListTile(
          leadingWidget: Image.asset(AssetPath.securityLockIcon),
          title: Strings.resetTransactionPin,
          subtitle: Strings.changeTranPinSubText2,
          hasTrailingIcon: true,
          onTap: () {
            ref
                .read(resetTransactionPinProvider.notifier)
                .initiateTransactionPinReset();
            context.go("${Routes.dashboardMore}/${Routes.initiateResetPin}");
          },
        ),
        RexListTile(
          leadingWidget: Image.asset(AssetPath.securityShieldIcon),
          title: Strings.changeSecurityQuestion,
          subtitle: Strings.changeSecurityQuestionSubText,
          hasTrailingIcon: true,
          onTap: () {
            context.push(
              "${Routes.dashboardMore}/${Routes.securityQuestionPin}",
            );
          },
        ),
      ],
    );
  }
}
