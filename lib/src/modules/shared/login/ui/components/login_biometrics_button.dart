import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/shared/login/providers/login_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_elevated_button.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class LoginBiometricsButton extends ConsumerWidget {
  const LoginBiometricsButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.aw),
      child: RexElevatedButton(
        onPressed: () {
          //ref.read(loginProvider.notifier).callBiometrics(context);
        },
        buttonTitle: StringAssets.loginWithBiometricsButton,
        backgroundColor: AppColors.softBlue,
      ),
    );
  }
}
