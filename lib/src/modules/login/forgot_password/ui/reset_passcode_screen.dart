import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/login/forgot_password/provider/forgot_password_provider.dart';
import 'package:rex_app/src/modules/login/forgot_password/provider/forgot_password_state.dart';
import 'package:rex_app/src/modules/utils/general/constants.dart';
import 'package:rex_app/src/modules/utils/routes/route_name.dart';
import 'package:rex_app/src/modules/utils/theme/app_colors.dart';
import 'package:rex_app/src/modules/utils/widgets/app_dialogs.dart';
import 'package:rex_app/src/modules/utils/widgets/app_scaffold.dart';
import 'package:rex_app/src/modules/utils/widgets/appbar_sub_screen.dart';
import 'package:rex_app/src/modules/utils/widgets/rex_elevated_button.dart';
import 'package:rex_app/src/modules/utils/widgets/rex_passcode_field.dart';

class ResetPasscodeScreen extends ConsumerWidget {
  const ResetPasscodeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(forgotPasswordProvider);
    //
    ref.listen(forgotPasswordProvider, (prev, next) {
      if (!context.mounted) return;
      // Only react to a new outcome, otherwise the resend countdown ticks
      // would re-open the dialog every second.
      if (prev?.event == next.event) return;
      final notifier = ref.read(forgotPasswordProvider.notifier);
      switch (next.event) {
        case ForgotPasswordEvent.otpResendFailed:
        case ForgotPasswordEvent.passcodeResetFailed:
          showAppDialog(
            context: context,
            title: 'Reset Passcode Error',
            body: next.msgError,
            icon: Icons.error,
            onPressed: () => context.pop(),
          );
          notifier.resetMessage();
        case ForgotPasswordEvent.otpResent:
          showAppDialog(
            context: context,
            title: 'OTP Sent',
            body: next.msgSuccess,
            icon: Icons.check_circle,
            onPressed: () => context.pop(),
          );
          notifier.resetMessage();
        case ForgotPasswordEvent.passcodeReset:
          showAppDialog(
            context: context,
            title: 'Passcode Reset',
            body: next.msgSuccess,
            icon: Icons.check_circle,
            barrierDismissible: false,
            onPressed: () {
              context.pop();
              notifier.clearFields();
              context.go(Routes.login);
            },
          );
          notifier.resetMessage();
        default:
          break;
      }
    });
    //
    return AppScaffold(
      isLoading: state.isLoading,
      backgroundColor: AppColors.rexBackground,
      padding: EdgeInsets.all(0),
      resizeToAvoidBottomInset: true,
      appBar: AppbarLoginScreen(
        onBackBtnPress: () => context.pop(),
      ),
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
                  'Reset Passcode',
                  style: TextStyle(
                    fontSize: 28.asp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.rexPurpleDark,
                  ),
                ),
                SizedBox(height: 6.ah),
                Text(
                  'Enter the code sent to your email and set a new passcode',
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RexPasscodeField(
                  controller: state.otp,
                  outerTitle: 'OTP',
                  hintText: 'Enter 6-digit OTP',
                  textInputAction: TextInputAction.next,
                ),
                SizedBox(height: 4.ah),
                RexPasscodeField(
                  controller: state.newPasscode,
                  outerTitle: 'New Passcode',
                  hintText: 'Enter 6-digit passcode',
                  textInputAction: TextInputAction.next,
                ),
                SizedBox(height: 4.ah),
                RexPasscodeField(
                  controller: state.confirmPasscode,
                  outerTitle: 'Confirm Passcode',
                  hintText: 'Confirm 6-digit passcode',
                  textInputAction: TextInputAction.done,
                ),
              ],
            ),
          ),
          SizedBox(height: 8.ah),
          Align(
            alignment: Alignment.center,
            child: TextButton(
              onPressed: state.canResendOtp
                  ? () => ref.read(forgotPasswordProvider.notifier).resendOtp()
                  : null,
              child: Text(
                state.canResendOtp
                    ? 'Resend OTP'
                    : 'Resend OTP in ${_formatCountdown(state.resendCountdown)}',
                style: TextStyle(
                  fontSize: 12.asp,
                  fontWeight: FontWeight.w600,
                  color: state.canResendOtp
                      ? AppColors.rexPurpleDark
                      : AppColors.rexTint500,
                ),
              ),
            ),
          ),
          SizedBox(height: 16.ah),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.aw),
            child: RexElevatedButton(
              onPressed: () {
                ref.read(forgotPasswordProvider.notifier).resetPasscode();
              },
              buttonTitle: 'Reset Passcode',
            ),
          ),
          SizedBox(height: 24.ah),
        ],
      ),
    );
  }
}

String _formatCountdown(int seconds) {
  final minutes = seconds ~/ 60;
  final remainder = seconds % 60;
  return '$minutes:${remainder.toString().padLeft(2, '0')}';
}
