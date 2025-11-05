import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/shared/forgot_password/provider/initiate_password_provider.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_text_field.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class InitiateResetUsernameField extends ConsumerWidget {
  const InitiateResetUsernameField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(initiatePasswordProvider);
    return RexTextField(
      hintText: Strings.usernameText2,
      controller: provider.nameController,
      obscureText: false,
      outerTitle: Strings.usernameText,
      showOuterTile: true,
      maxLines: 1,
      inputType: TextInputType.text,
      textInputAction: TextInputAction.done,
      onChanged: (value) {
        ref.read(usernameProvider.notifier).state = value;
      },
    );
  }
}
