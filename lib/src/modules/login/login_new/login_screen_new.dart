import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/login/login_new/login_email_tab.dart';
import 'package:rex_app/src/modules/login/login_new/login_new_header.dart';
import 'package:rex_app/src/modules/login/login_new/login_passcode_body.dart';
import 'package:rex_app/src/modules/login/login_new/login_phone_tab.dart';
import 'package:rex_app/src/modules/login/login_new/rex_tab_view.dart';
import 'package:rex_app/src/modules/login/provider/login_provider.dart';
import 'package:rex_app/src/modules/login/provider/login_screen_state.dart';
import 'package:rex_app/src/modules/utils/extensions/extension_on_string.dart';
import 'package:rex_app/src/modules/utils/general/app_keys.dart';
import 'package:rex_app/src/modules/utils/general/constants.dart';
import 'package:rex_app/src/modules/utils/routes/route_name.dart';
import 'package:rex_app/src/modules/utils/theme/app_colors.dart';
import 'package:rex_app/src/modules/utils/widgets/app_dialogs.dart';
import 'package:rex_app/src/modules/utils/widgets/app_scaffold.dart';
import 'package:rex_app/src/modules/utils/widgets/appbar_sub_screen.dart';
import 'package:rex_app/src/modules/utils/widgets/rex_elevated_button.dart';

class LoginScreenNew extends ConsumerStatefulWidget {
  const LoginScreenNew({super.key});

  @override
  ConsumerState<LoginScreenNew> createState() => _LoginScreenNewState();
}

class _LoginScreenNewState extends ConsumerState<LoginScreenNew> {
  /// The terminal is bound to a single account, so a saved identifier means the
  /// passcode is the only thing left to collect. Captured once so the body does
  /// not swap under the user when the first login persists the identifier.
  late final String _savedUsername = AppKeysStorage.getConfig().loginUsername;

  @override
  Widget build(BuildContext context) {
    //
    ref.listen(loginProvider, (prev, next) {
      if (!context.mounted) return;
      // Only react to a new outcome, so state changes made while the
      // verification screen is on top do not re-trigger this listener.
      if (prev?.event == next.event) return;
      final notifier = ref.read(loginProvider.notifier);
      switch (next.event) {
        case LoginEvent.failed:
          showAppDialog(
            context: context,
            title: 'Login Error',
            body: next.msgError,
            icon: Icons.error,
            onPressed: () {
              context.pop();
              notifier.resetMessage();
            },
          );
        case LoginEvent.locationOtpRequired:
          notifier.resetMessage();
          context.push(Routes.verifyLocationOtp);
        case LoginEvent.success:
          notifier.resetMessage();
          notifier.clearFields();
          context.go(Routes.loginHome);
        case LoginEvent.none:
          break;
      }
    });
    //
    return AppScaffold(
      isLoading: ref.watch(loginProvider).isLoading,
      backgroundColor: AppColors.rexBackground,
      padding: EdgeInsets.all(0),
      resizeToAvoidBottomInset: true,
      appBar: AppbarLoginScreen(
        onBackBtnPress: () => context.go(Routes.homeScreen),
      ),
      body:
          _savedUsername.isNotBlank
              ? LoginPasscodeBody(savedUsername: _savedUsername)
              : LoginScreenBody(),
    );
  }
}

class LoginScreenBody extends ConsumerWidget {
  const LoginScreenBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        SizedBox(height: 16.ah),
        LoginNewHeader(),
        SizedBox(height: 24.ah),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.aw),
          child: RexTabView(
            tabLabels: const ['Email Address', 'Phone Number'],
            tabViews: [LoginEmailTab(), LoginPhoneTab()],
            onTabChanged: (value) {
              ref.read(loginProvider.notifier).setSelectedTab(value);
            },
          ),
        ),

        SizedBox(height: 16.ah),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.aw),
          child: RexElevatedButton(
            onPressed: () {
              ref.read(loginProvider.notifier).validate();
            },
            buttonTitle: 'Continue',
          ),
        ),
        SizedBox(height: 24.ah),
      ],
    );
  }
}
