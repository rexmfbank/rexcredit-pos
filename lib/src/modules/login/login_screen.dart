import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/home/widget/app_version_text.dart';
import 'package:rex_app/src/modules/login/provider/login_provider.dart';
import 'package:rex_app/src/modules/login/widgets/login_screen_button.dart';
import 'package:rex_app/src/modules/login/widgets/login_screen_password.dart';
import 'package:rex_app/src/modules/login/widgets/login_screen_username.dart';
import 'package:rex_app/src/modules/utils/routes/route_name.dart';
import 'package:rex_app/src/modules/utils/theme/app_colors.dart';
import 'package:rex_app/src/modules/utils/widgets/appbar_sub_screen.dart';
import 'package:rex_app/src/modules/utils/general/constants.dart';

import '../utils/widgets/app_scaffold.dart';

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
      //ref.read(loginProvider.notifier).checkUserName();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      isLoading: ref.watch(loginProvider).isLoading,
      backgroundColor: AppColors.rexBackground,
      padding: EdgeInsets.all(0),
      resizeToAvoidBottomInset: true,
      appBar: AppbarSubScreen(
        title: 'Login',
        onBackBtnPress: () => context.go(Routes.homeScreen),
      ),
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
