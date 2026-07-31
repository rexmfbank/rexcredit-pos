import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/login/provider/login_provider.dart';
import 'package:rex_app/src/modules/login/verify_location/provider/verify_location_provider.dart';
import 'package:rex_app/src/modules/login/verify_location/provider/verify_location_state.dart';
import 'package:rex_app/src/modules/utils/extensions/extension_on_string.dart';
import 'package:rex_app/src/modules/utils/general/constants.dart';
import 'package:rex_app/src/modules/utils/routes/route_name.dart';
import 'package:rex_app/src/modules/utils/theme/app_colors.dart';
import 'package:rex_app/src/modules/utils/widgets/app_dialogs.dart';
import 'package:rex_app/src/modules/utils/widgets/app_scaffold.dart';
import 'package:rex_app/src/modules/utils/widgets/appbar_sub_screen.dart';
import 'package:rex_app/src/modules/utils/widgets/rex_elevated_button.dart';
import 'package:rex_app/src/modules/utils/widgets/rex_passcode_field.dart';

/// Collects the OTP the backend sends when a login comes from a location it
/// does not recognise yet.
class VerifyLocationScreen extends ConsumerWidget {
  const VerifyLocationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(verifyLocationProvider);
    final challengeMessage = ref.read(loginProvider.notifier).locationOtpMessage;
    //
    ref.listen(verifyLocationProvider, (prev, next) {
      if (!context.mounted) return;
      // Only react to a new outcome, otherwise typing would re-open the dialog.
      if (prev?.event == next.event) return;
      final notifier = ref.read(verifyLocationProvider.notifier);
      if (next.event == VerifyLocationEvent.failed) {
        showAppDialog(
          context: context,
          title: 'Verification Error',
          body: next.msgError,
          icon: Icons.error,
          onPressed: () => context.pop(),
        );
        notifier.resetMessage();
      } else if (next.event == VerifyLocationEvent.verified) {
        notifier.resetMessage();
        notifier.clearFields();
        ref.read(loginProvider.notifier).clearFields();
        context.go(Routes.loginHome);
      }
    });
    //
    return AppScaffold(
      isLoading: state.isLoading,
      backgroundColor: AppColors.rexBackground,
      padding: EdgeInsets.all(0),
      resizeToAvoidBottomInset: true,
      appBar: AppbarLoginScreen(onBackBtnPress: () => context.pop()),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          SizedBox(height: 16.ah),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.aw),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Verify It Is You',
                  style: TextStyle(
                    fontSize: 28.asp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.rexPurpleDark,
                  ),
                ),
                SizedBox(height: 6.ah),
                Text(
                  challengeMessage.isNotBlank
                      ? challengeMessage
                      : 'We sent you a code to confirm this login. Enter it '
                          'below to continue.',
                  style: TextStyle(
                    fontSize: 14.asp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.rexTint500,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 24.ah),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.aw),
            child: RexPasscodeField(
              controller: state.otp,
              outerTitle: 'OTP',
              hintText: 'Enter 6-digit OTP',
              textInputAction: TextInputAction.done,
              autoFocus: true,
            ),
          ),
          SizedBox(height: 24.ah),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.aw),
            child: RexElevatedButton(
              onPressed:
                  () => ref.read(verifyLocationProvider.notifier).verify(),
              buttonTitle: 'Verify',
            ),
          ),
          SizedBox(height: 24.ah),
        ],
      ),
    );
  }
}
