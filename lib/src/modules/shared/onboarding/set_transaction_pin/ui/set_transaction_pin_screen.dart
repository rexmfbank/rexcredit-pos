import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/shared/onboarding/set_transaction_pin/provider/set_transaction_pin_provider.dart';
import 'package:rex_app/src/modules/shared/onboarding/set_transaction_pin/ui/components/pin_explanation_text.dart';
import 'package:rex_app/src/modules/shared/widgets/custom_keyboard.dart';
import 'package:rex_app/src/modules/shared/widgets/custom_keyboard_theme.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class SetTransactionPinScreen extends ConsumerWidget {
  const SetTransactionPinScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: const RexAppBar(
          shouldHaveBackButton: false,
          step: StringAssets.emptyString,
          title: StringAssets.setPinTitle,
          subtitle: StringAssets.setPinSubtitle,
        ),
        body: Column(
          children: [
            const SizedBox(height: 4.0),
            const Expanded(
              child: PinExplanationText(),
            ),
            Expanded(
              flex: 6,
              child: CustomKeyBoard(
                maxLength: 4,
                pinTheme: CustomKeyboardTheme(
                  submitColor: AppColors.rexBlack,
                  textColor: AppColors.rexBlack,
                  keysColor: AppColors.rexBlack,
                ),
                onChanged: (value) {
                  ref.read(setTransactionPinProvider.notifier).setPin(value);
                },
                onbuttonClick: () {
                  ref
                      .read(setTransactionPinProvider.notifier)
                      .validatePIN(context);
                },
              ),
            ),
            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }
}
