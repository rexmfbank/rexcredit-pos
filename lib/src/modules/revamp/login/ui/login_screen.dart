import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/utils/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/revamp/login/providers/login_provider.dart';
import 'package:rex_app/src/modules/revamp/login/ui/components/app_version_text.dart';
import 'package:rex_app/src/modules/revamp/login/ui/components/login_screen_button.dart';
import 'package:rex_app/src/modules/revamp/login/ui/components/login_screen_password.dart';
import 'package:rex_app/src/modules/revamp/login/ui/components/login_screen_username.dart';
import 'package:rex_app/src/modules/revamp/pos_device/notifier/pos_global_notifier.dart';
import 'package:rex_app/src/modules/revamp/widget/appbar_sub_screen.dart';
import 'package:rex_app/src/modules/shared/widgets/page_widgets/app_scaffold.dart';
import 'package:rex_app/src/utils/constants/constants.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((_) {
      ref.read(posGlobalProvider.notifier).checkBaseAppInstalled();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      isLoading: ref.watch(loginProvider).isLoading,
      backgroundColor: AppColors.rexBackground,
      padding: EdgeInsets.all(0),
      resizeToAvoidBottomInset: true,
      appBar: AppbarSubScreen(title: 'Login'),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          SizedBox(height: 16.ah),
          const LoginScreenUsername(),
          const LoginScreenPassword(),
          const LoginScreenButton(),
          const AppVersionText(),
        ],
      ),
    );
  }
}
