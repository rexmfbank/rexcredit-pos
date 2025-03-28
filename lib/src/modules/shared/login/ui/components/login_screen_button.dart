import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/shared/login/providers/login_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_elevated_button.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class LoginScreenButton extends ConsumerWidget {
  const LoginScreenButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.aw),
      child: RexElevatedButton(
        onPressed: () {
          ref.read(loginProvider.notifier).validate(context);
        },
        buttonTitle: StringAssets.nextTextOnButton,
        backgroundColor: null,
      ),
    );
  }
}
