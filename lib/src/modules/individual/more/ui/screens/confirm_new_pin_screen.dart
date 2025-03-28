import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:rex_api/rex_api.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/individual/save/old_ui_components/custom_error_dialog.dart';
import 'package:rex_app/src/modules/shared/login/providers/login_provider.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/custom_keyboard.dart';
import 'package:rex_app/src/modules/shared/widgets/custom_keyboard_theme.dart';
import 'package:rex_app/src/modules/shared/widgets/loading_screen.dart';
import 'package:rex_app/src/modules/shared/widgets/modal_bottom_sheets/show_modal_action.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/utils/constants/asset_path.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/providers/meta_data_provider.dart';
import '../../profile/providers/change_transaction_pin_provider.dart';

class ConfirmNewPinScreen extends ConsumerWidget {
  const ConfirmNewPinScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String pin = '';
    final authToken = ref.watch(userAuthTokenProvider) ?? 'null';
    final setPin = ref.watch(oldPinProvider);
    final newPin = ref.watch(newPinProvider);
    final confirmPin = ref.watch(confirmPinProvider);
    final meta = ref.watch(deviceMetaProvider).asData?.value;
    //
    ref.listen(
      resetPinApiProvider,
      (_, state) {
        state.when(
          data: (data) {
            LoadingScreen.instance().hide();
            showModalAction(
                context: context,
                dialogTitle: 'PIN changed succesfully!',
                dialogSubtitle:
                    'You account is well protected with your new transaction PIN',
                onPressed: () {
                  context.pop();
                  context.pop();
                },
                lottieAnimation:
                    Lottie.asset('assets/lottiefiles/success_tick.json'));
          },
          error: (error, stackTrace) {
            LoadingScreen.instance().hide();
            showModalAction(
              context: context,
              dialogTitle: error.toString(),
              dialogSubtitle: error.toString(),
              lottieAnimation: Lottie.asset(AssetPath.warningStatus),
              onPressed: () {
                context.pop();
              },
            );
          },
          loading: () {
            LoadingScreen.instance().show(context: context);
          },
        );
      },
    );
    //
    return Scaffold(
      appBar: const RexAppBar(
        shouldHaveBackButton: true,
        step: StringAssets.emptyString,
        title: StringAssets.confirmNewPinTitle,
        subtitle: StringAssets.confirmNewPinSubtitle,
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
                ref.read(confirmPinProvider.notifier).onChanged(v);
              },
              onbuttonClick: () {
                if (pin.length > 4) {
                  showCustomErrorDialog(
                      context: context,
                      errorText: 'Enter a valid PIN. Must be 4 digits!');
                } else {
                  if (newPin == confirmPin) {
                    ref.read(resetPinApiProvider.notifier).resetPin(
                          token: authToken,
                          request: ChangePinRequest(
                              oldPin: setPin,
                              newPin: newPin,
                              entityCode: ref.read(loginProvider).loginResponse.value?.data.entityCode ?? 'RMB',
                              deviceId: meta?.deviceNumber ?? 'deviceId'),
                        );
                  } else {
                    showModalAction(
                      context: context,
                      dialogTitle: 'Incorrect PIN',
                      dialogSubtitle:
                          'Please input the correct PIN or go back to start again',
                      lottieAnimation: Lottie.asset(
                          'assets/lottiefiles/warning-status.json'),
                      onPressed: () {
                        context.pop();
                      },
                    );
                  }
                }
                // modalDialogPinChange(context: context);
              },
            ),
          ),
          const SizedBox(height: 60),
        ],
      ),
    );
  }
}
