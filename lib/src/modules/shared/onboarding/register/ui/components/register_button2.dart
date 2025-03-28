import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/shared/onboarding/register/provider/register_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_elevated_button.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class RegisterButton2 extends ConsumerWidget {
  const RegisterButton2({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final register = ref.watch(registerProvider);
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
      child: RexElevatedButton(
        backgroundColor: register.enableSubmission ? null : AppColors.grey,
        buttonTitle: register.enableSubmission
            ? StringAssets.nextTextOnButton
            : StringAssets.pleaseWait,
        onPressed: register.enableSubmission
            ? () => ref
                .read(registerProvider.notifier)
                .validateInputAndRegister(context)
            : null,
      ),
    );
  }
}
