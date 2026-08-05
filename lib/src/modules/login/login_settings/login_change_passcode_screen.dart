import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/login/login_settings/provider/change_passcode_provider.dart';
import 'package:rex_app/src/modules/login/login_settings/provider/change_passcode_state.dart';
import 'package:rex_app/src/modules/utils/general/constants.dart';
import 'package:rex_app/src/modules/utils/theme/app_colors.dart';
import 'package:rex_app/src/modules/utils/widgets/app_dialogs.dart';
import 'package:rex_app/src/modules/utils/widgets/app_scaffold.dart';
import 'package:rex_app/src/modules/utils/widgets/appbar_sub_screen.dart';
import 'package:rex_app/src/modules/utils/widgets/rex_elevated_button.dart';
import 'package:rex_app/src/modules/utils/widgets/rex_passcode_field.dart';

class LoginChangePasscodeScreen extends ConsumerWidget {
  const LoginChangePasscodeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(changePasscodeProvider);
    //
    ref.listen(changePasscodeProvider, (prev, next) {
      if (!context.mounted) return;
      if (prev?.event == next.event) return;
      final notifier = ref.read(changePasscodeProvider.notifier);
      switch (next.event) {
        case ChangePasscodeEvent.failed:
          showAppDialog(
            context: context,
            title: 'Change Passcode Error',
            body: next.msgError,
            icon: Icons.error,
            onPressed: () => context.pop(),
          );
          notifier.resetMessage();
        case ChangePasscodeEvent.success:
          showAppDialog(
            context: context,
            title: 'Passcode Changed',
            body: next.msgSuccess,
            icon: Icons.check_circle,
            barrierDismissible: false,
            onPressed: () {
              context.pop();
              notifier.clearFields();
              context.pop();
            },
          );
          notifier.resetMessage();
        case ChangePasscodeEvent.none:
          break;
      }
    });
    //
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          ref.read(changePasscodeProvider.notifier).clearFields();
        }
      },
      child: AppScaffold(
        isLoading: state.isLoading,
        backgroundColor: AppColors.rexBackground,
        padding: EdgeInsets.all(0),
        resizeToAvoidBottomInset: true,
        appBar: const AppbarSubScreen(
          title: 'Change Passcode',
          centerTitle: true,
        ),
        body: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            SizedBox(height: 16.ah),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.aw),
              child: Text(
                'Enter your current passcode and set a new one',
                style: TextStyle(
                  fontSize: 14.asp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.rexTint500,
                ),
              ),
            ),
            SizedBox(height: 24.ah),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.aw),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RexPasscodeField(
                    controller: state.currentPasscode,
                    outerTitle: 'Current Passcode',
                    hintText: 'Enter current 6-digit passcode',
                    textInputAction: TextInputAction.next,
                  ),
                  SizedBox(height: 4.ah),
                  RexPasscodeField(
                    controller: state.newPasscode,
                    outerTitle: 'New Passcode',
                    hintText: 'Enter new 6-digit passcode',
                    textInputAction: TextInputAction.next,
                  ),
                  SizedBox(height: 4.ah),
                  RexPasscodeField(
                    controller: state.confirmPasscode,
                    outerTitle: 'Confirm Passcode',
                    hintText: 'Confirm new 6-digit passcode',
                    textInputAction: TextInputAction.done,
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.ah),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.aw),
              child: RexElevatedButton(
                onPressed: () {
                  ref.read(changePasscodeProvider.notifier).changePasscode();
                },
                buttonTitle: 'Change Passcode',
              ),
            ),
            SizedBox(height: 24.ah),
          ],
        ),
      ),
    );
  }
}
