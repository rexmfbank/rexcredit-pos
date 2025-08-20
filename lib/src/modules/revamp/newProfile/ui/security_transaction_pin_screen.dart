import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/newProfile/provider/security_question_screen_notifier.dart';
import 'package:rex_app/src/modules/revamp/utils/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/shared/widgets/page_widgets/app_scaffold.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_elevated_button.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_text_field_password.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class SecurityTransactionPinScreen extends ConsumerWidget {
  const SecurityTransactionPinScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(securityQuestionScreenProvider);

    return AppScaffold(
      backgroundColor: AppColors.rexBackground,
      padding: EdgeInsets.all(0),
      isLoading: provider.isLoading,
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
                ref
                    .read(securityQuestionScreenProvider.notifier)
                    .validateTransactionPin(context: context);
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
