import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:rex_app/src/modules/revamp/utils/config/routes/route_name.dart';
import 'package:rex_app/src/modules/revamp/utils/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/individual/more/ui/components/bvn_explanation_text.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/loading_screen.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_elevated_button.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_error_dialog.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_text_field.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';
import 'package:go_router/go_router.dart';

class EnterBvnScreen extends HookConsumerWidget {
  const EnterBvnScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bvnController = useTextEditingController();
    final authToken = ref.watch(appAuthTokenProvider) ?? 'null';
    //
    return Scaffold(
      appBar: const RexAppBar(
        step: StringAssets.emptyString,
        shouldHaveBackButton: true,
        title: StringAssets.bvnScreenTitle,
        subtitle: StringAssets.bvnScreenSubtitle,
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 16.0,
          right: 16.0,
          top: 8.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 170,
              decoration: BoxDecoration(
                color: AppColors.cardBlue,
                borderRadius: BorderRadius.circular(14),
              ),
              child: const BvnExplanationText(),
            ),
            RexTextField(
              outerTitle: StringAssets.bvnScreenTitle,
              hintText: StringAssets.emptyString,
              controller: bvnController,
              obscureText: false,
              maxLength: 11,
            ),
            RexElevatedButton(
              onPressed: () {
                context.go("${Routes.dashboardMore}/${Routes.updateAccount}");
              },
              buttonTitle: StringAssets.nextTextOnButton,
              backgroundColor: AppColors.rexBlack,
            ),
            const Text(
              'Skip for now',
              style: TextStyle(
                color: AppColors.grey,
                decoration: TextDecoration.underline,
                decorationColor: AppColors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
