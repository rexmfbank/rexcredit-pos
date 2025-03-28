import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:rex_app/src/modules/shared/onboarding/register/provider/register_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_text_field.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class RegisterBirthDate extends ConsumerWidget {
  const RegisterBirthDate({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(registerProvider);
    //
    return Align(
      alignment: Alignment.centerLeft,
      child: GestureDetector(
        onTap: () {
          showDatePicker(
            context: context,
            initialDate: DateTime(2000),
            firstDate: DateTime(1950),
            lastDate: DateTime(2006),
          ).then((value) {
            ref.read(registerProvider.notifier).onDateSelectionChange(value);
          });
        },
        child: RexTextField(
          outerTitle: StringAssets.dobText,
          obscureText: false,
          hintText: provider.dateOfBirth == null
              ? ''
              : DateFormat.yMMMd().format(provider.dateOfBirth!),
          controller: provider.dobController,
          showOuterTile: true,
          textFieldIsRequired: true,
          enabled: false,
        ),
      ),
    );
  }
}
