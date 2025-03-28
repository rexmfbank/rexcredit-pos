import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_text_field.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class BusinessYearsLocationField extends HookConsumerWidget {
  const BusinessYearsLocationField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const RexTextField(
      outerTitle: StringAssets.bizTextTitle3,
      hintText: '',
      controller: null,
      obscureText: false,
      showOuterTile: true,
      inputType: TextInputType.number,
      textFieldIsRequired: true,
    );
  }
}
