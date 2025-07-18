import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/newProfile/security_question_screen_notifier.dart';
import 'package:rex_app/src/modules/revamp/utils/config/routes/route_name.dart';
import 'package:rex_app/src/modules/revamp/newProfile/security_question_providers.dart';
import 'package:rex_app/src/modules/shared/widgets/extension/snack_bar_ext.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_elevated_button.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_text_field_password.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';
import 'package:go_router/go_router.dart';

class SecurityTransactionPinScreen extends ConsumerWidget {
  const SecurityTransactionPinScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(securityQuestionScreenProvider);

    return Scaffold(
      appBar: const RexAppBar(
        shouldHaveBackButton: true,
        step: null,
        title: StringAssets.enterTransactionPinTitle,
        subtitle: StringAssets.enterTransactionPinSubtitle,
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          const SizedBox(height: 8),
          RexTextFieldPassword(
            outerTitle: 'Enter Transaction PIN',
            hintText: '',
            controller: provider.pinController,
            obscureText: true,
            inputType: TextInputType.number,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RexElevatedButton(
              onPressed: () {
                if (provider.pinController.text.length > 4) {
                  context.showToast(message: 'PIN must be 4 digits only.');
                } else {
                  ref
                      .read(securityQuestionListProvider.notifier)
                      .getSecurityQuestionList();
                  context.go(
                    "${Routes.dashboardMore}/${Routes.securityQuestionChange}",
                  );
                }
              },
              buttonTitle: 'Next',
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
