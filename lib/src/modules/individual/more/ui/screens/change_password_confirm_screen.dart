import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/utils/config/routes/route_name.dart';
import 'package:rex_app/src/modules/revamp/utils/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_elevated_button.dart';
import 'package:rex_app/src/utils/constants/asset_path.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';
import 'package:go_router/go_router.dart';

class ChangePasswordConfirmScreen extends ConsumerWidget {
  const ChangePasswordConfirmScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const RexAppBar(
        step: '',
        shouldHaveBackButton: true,
        title: 'Password Changed',
        subtitle: 'You have successfully changed your Rex account password',
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
              'Password change successful',
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
                'You can now login with your new password',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ),
          const SizedBox(height: 32),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: RexElevatedButton(
              onPressed: () {
                context.go("${Routes.dashboardMore}/${Routes.profile}");
              },
              buttonTitle: StringAssets.confirmTextOnButton,
              backgroundColor: AppColors.rexPurpleDark,
            ),
          ),
        ],
      ),
    );
  }
}
