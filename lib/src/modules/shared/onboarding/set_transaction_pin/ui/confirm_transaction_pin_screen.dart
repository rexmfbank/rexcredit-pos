import 'package:flutter/material.dart';
import 'package:rex_app/src/config/routes/route_name.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/shared/onboarding/set_transaction_pin/provider/set_transaction_pin_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/custom_keyboard.dart';
import 'package:rex_app/src/modules/shared/widgets/custom_keyboard_theme.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';

class ConfirmTransactionPinScreen extends ConsumerWidget {
  const ConfirmTransactionPinScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: RexAppBar(
        shouldHaveBackButton: true,
        step: StringAssets.emptyString,
        title: StringAssets.confirmPinTitle,
        subtitle: StringAssets.confirmPinSubtitle,
        onBackButtonPressed: () {
          context.go(RouteName.setTransactionPin);
        },
      ),
      body: Column(
        children: [
          //const PinErrorText(),
          Expanded(
            child: CustomKeyBoard(
              maxLength: 4,
              pinTheme: CustomKeyboardTheme(
                submitColor: AppColors.rexBlack,
                textColor: AppColors.rexBlack,
                keysColor: AppColors.rexBlack,
              ),
              onChanged: (v) {
                ref.read(setTransactionPinProvider.notifier).setConfirmPin(v);
              },
              onbuttonClick: () {
                ref
                    .read(setTransactionPinProvider.notifier)
                    .setTransactionPin(context);
              },
            ),
          ),
          const SizedBox(height: 60),
        ],
      ),
    );
  }
}
