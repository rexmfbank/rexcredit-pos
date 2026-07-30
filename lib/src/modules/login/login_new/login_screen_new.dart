import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/login/login_new/login_email_tab.dart';
import 'package:rex_app/src/modules/login/login_new/login_new_header.dart';
import 'package:rex_app/src/modules/login/login_new/login_phone_tab.dart';
import 'package:rex_app/src/modules/login/login_new/rex_tab_view.dart';
import 'package:rex_app/src/modules/login/provider/login_provider.dart';
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
  @override
  Widget build(BuildContext context) {
    //
    ref.listen(loginProvider, (prev, next) {
      if (!context.mounted) return;
      if (next.msgError.isNotEmpty) {
        showAppDialog(
          context: context,
          title: 'Login Error',
          body: next.msgError,
          icon: Icons.error,
          onPressed: () {
            context.pop();
            ref.read(loginProvider.notifier).resetMessage();
          },
        );
      } else if (next.msgSuccess.isNotEmpty) {
        ref.read(loginProvider.notifier).resetMessage();
        context.go(Routes.loginHome);
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
      body: LoginScreenBody(),
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
