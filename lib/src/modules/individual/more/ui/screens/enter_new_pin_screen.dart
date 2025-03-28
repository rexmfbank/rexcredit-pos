import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/individual/more/ui/screens/confirm_new_pin_screen.dart';
import 'package:rex_app/src/modules/individual/save/old_ui_components/custom_error_dialog.dart';
import 'package:rex_app/src/modules/shared/widgets/custom_keyboard.dart';
import 'package:rex_app/src/modules/shared/widgets/custom_keyboard_theme.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/utils/constants/navigation.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

import '../../profile/providers/change_transaction_pin_provider.dart';

class EnterNewPinScreen extends ConsumerWidget {
  const EnterNewPinScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String pin = '';

    return Scaffold(
      appBar: const RexAppBar(
        step: StringAssets.emptyString,
        shouldHaveBackButton: true,
        title: StringAssets.enterNewPinTitle,
        subtitle: StringAssets.enterNewPinSubtitle,
      ),
      body: Column(
        children: [
          Expanded(
            child: CustomKeyBoard(
              maxLength: 4,
              pinTheme: CustomKeyboardTheme(
                submitColor: AppColors.rexBlack,
                textColor: AppColors.rexBlack,
                keysColor: AppColors.rexBlack,
              ),
              onChanged: (v) {
                if (kDebugMode) {
                  print(v);
                }
                pin = v;
                ref.read(newPinProvider.notifier).onChanged(v);
              },
              onbuttonClick: () {
                if (pin.length < 4) {
                  showCustomErrorDialog(
                      context: context,
                      errorText: 'Enter a valid PIN. Must be 4 digits!');
                } else {
                  ref.read(newPinProvider.notifier).onChanged(pin);
                  context.pushReplacementSuper(
                    const ConfirmNewPinScreen(),
                  );
                }
              },
            ),
          ),
          const SizedBox(height: 60),
        ],
      ),
    );
  }
}
