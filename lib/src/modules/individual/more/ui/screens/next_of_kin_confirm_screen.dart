import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/revamp/utils/config/routes/route_name.dart';
import 'package:rex_app/src/modules/revamp/utils/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_elevated_button.dart';
import 'package:rex_app/src/utils/constants/asset_path.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';

class NextOfKinConfirmScreen extends ConsumerWidget {
  const NextOfKinConfirmScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const RexAppBar(
        shouldHaveBackButton: true,
        step: StringAssets.emptyString,
        title: StringAssets.kinConfirmTitle,
        subtitle: StringAssets.kinConfirmSubtitle,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(AssetPath.checkmarkImage),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              StringAssets.nokConfirmedTitle,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const Flexible(
            child: Padding(
              padding: EdgeInsets.only(left: 16.0, right: 16.0),
              child: Text(
                StringAssets.nokConfirmedSubtitle,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ),
          Expanded(child: Container()),
          RexElevatedButton(
            onPressed: () {
              ref.read(verifiedNextOfKinProvider.notifier).state = true;
              context.go(
                "${Routes.dashboardMore}/${Routes.updateAccount}",
              );
            },
            buttonTitle: StringAssets.continueTextOnButton,
            backgroundColor: AppColors.rexBlack,
          ),
        ],
      ),
    );
  }
}
