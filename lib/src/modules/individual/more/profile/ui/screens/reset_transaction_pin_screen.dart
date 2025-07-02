import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:rex_app/src/modules/revamp/utils/config/routes/route_name.dart';
import 'package:rex_app/src/modules/individual/more/profile/providers/reset_transaction_pin_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/modal_bottom_sheets/show_modal_action.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_flat_button.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_text_field.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';
import 'package:rex_app/src/utils/extensions/extension_on_string.dart';

class ResetTransactionPinOtpScreen extends ConsumerWidget {
  const ResetTransactionPinOtpScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(resetTransactionPinProvider);
    return Scaffold(
      appBar: const RexAppBar(
        shouldHaveBackButton: true,
        step: StringAssets.emptyString,
        title: StringAssets.resetTransactionPin,
        subtitle: StringAssets.resetPinSubtitle,
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 200,
            child: Lottie.asset('assets/lottiefiles/password_lock.json'),
          ),
          RexTextField(
            hintText: StringAssets.otpTitle,
            controller: provider.otpController,
            obscureText: false,
            showOuterTile: true,
            inputType: TextInputType.number,
            maxLines: 1,
            outerTitle: StringAssets.otpTitle2,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: RexFlatButton(
              onPressed: () {
                if (provider.otpController.text.isNotBlank) {
                  context.push(
                      "${Routes.dashboardMore}/${Routes.resetTransactionPin}");
                } else {
                  showModalActionError(
                      context: context, errorText: 'Please input OTP');
                }
              },
              buttonTitle: StringAssets.nextTextOnButton,
              backgroundColor: null,
            ),
          ),
        ],
      ),
    );
  }
}
