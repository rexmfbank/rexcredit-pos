import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/config/routes/route_name.dart';
import 'package:rex_app/src/modules/individual/more/profile/providers/reset_transaction_pin_provider.dart';
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
          title: StringAssets.changePassword,
          subtitle: StringAssets.changePasswordSubtext,
          hasTrailingIcon: true,
          onTap: () {
            context.go(
              "${RouteName.dashboardMore}/${RouteName.changepassword}",
            );
          },
        ),
        RexListTile(
          leadingWidget: Image.asset(AssetPath.securityLockIcon),
          visible: false,
          title: StringAssets.changeTranPin,
          subtitle: StringAssets.changeTranPinSubText,
          hasTrailingIcon: true,
          onTap: () {
            context.go(
              "${RouteName.dashboardMore}/${RouteName.enterOldPin}",
            );
          },
        ),
        RexListTile(
          leadingWidget: Image.asset(AssetPath.securityLockIcon),
          title: StringAssets.resetTransactionPin,
          subtitle: StringAssets.changeTranPinSubText2,
          hasTrailingIcon: true,
          onTap: () {
            ref
                .read(resetTransactionPinProvider.notifier)
                .initiateTransactionPinReset();
            context.go(
              "${RouteName.dashboardMore}/${RouteName.initiateResetPin}",
            );
          },
        ),
        RexListTile(
          leadingWidget: Image.asset(AssetPath.securityShieldIcon),
          title: StringAssets.changeSecurityQuestion,
          subtitle: StringAssets.changeSecurityQuestionSubText,
          hasTrailingIcon: true,
          onTap: () {
            context.push(
              "${RouteName.dashboardMore}/${RouteName.securityQuestionPin}",
            );
          },
        ),
        RexListTile(
          leadingWidget: Image.asset(AssetPath.securityBioIcon),
          title: StringAssets.setUpBio,
          subtitle: StringAssets.enableBiometric,
          hasTrailingIcon: true,
          onTap: () {
            context
                .push('${RouteName.dashboardMore}/${RouteName.setupBiometric}');
          },
        ),
        RexListTile(
          leadingWidget: Image.asset(AssetPath.securityWalletIcon),
          title: StringAssets.tranWithdrawalLimit,
          subtitle: StringAssets.changeWithdrawalLimit,
          hasTrailingIcon: true,
          onTap: () {
            context.push(
                '${RouteName.dashboardMore}/${RouteName.withdrawalLimit}');
          },
        ),
      ],
    );
  }
}
