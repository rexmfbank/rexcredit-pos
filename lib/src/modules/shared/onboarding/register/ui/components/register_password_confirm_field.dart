import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/shared/onboarding/register/provider/register_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_text_field_password.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class RegisterPasswordConfirmField extends ConsumerWidget {
  const RegisterPasswordConfirmField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(registerProvider);
    //
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        provider.passwordNotMatch ? const PasswordNotMatchText() : Container(),
        RexTextFieldPassword(
          outerTitle: 'Confirm Password',
          hintText: '',
          controller: provider.passwordConfirmController,
          textFieldIsRequired: true,
          onChanged: (value) {
            ref
                .read(registerProvider.notifier)
                .confirmPassword(text: value, context: context);
          },
        ),
      ],
    );
  }
}

class PasswordNotMatchText extends StatelessWidget {
  const PasswordNotMatchText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(left: 16.0, bottom: 8.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          StringAssets.passwordNotMatch,
          style: TextStyle(
            color: AppColors.red,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
