import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/newProfile/reset_transaction_pin_provider.dart';
import 'package:rex_app/src/modules/revamp/utils/config/routes/route_name.dart';
import 'package:rex_app/src/modules/revamp/utils/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/shared/widgets/extension/snack_bar_ext.dart';
import 'package:rex_app/src/modules/shared/widgets/page_widgets/app_scaffold.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_flat_button.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_text_field.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';
import 'package:rex_app/src/utils/extensions/extension_on_string.dart';

class ResetTransactionPinScreen extends ConsumerWidget {
  const ResetTransactionPinScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(resetTransactionPinProvider);
    return AppScaffold(
      resizeToAvoidBottomInset: true,
      padding: EdgeInsets.all(0),
      backgroundColor: AppColors.rexBackground,
      isLoading: provider.isLoading,
      appBar: const RexAppBar(
        shouldHaveBackButton: true,
        step: StringAssets.emptyString,
        title: StringAssets.resetTransactionPin,
        subtitle: StringAssets.resetPinSubtitle,
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
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
                      "${Routes.dashboardMore}/${Routes.newTransactionPin}");
                } else {
                  context.showToast(message: "Please input OTP");
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
