import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/shared/models/text_field_validator.dart';
import 'package:rex_app/src/modules/shared/onboarding/onboard_individual/providers/complete_setup_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_text_field.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class CompleteSetupAddressField extends ConsumerWidget {
  const CompleteSetupAddressField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(completeSetupProvider);
    return RexTextField(
      hintText: StringAssets.addressHint,
      controller: provider.addressController,
      obscureText: false,
      outerTitle: StringAssets.address,
      showOuterTile: true,
      validator: (value) => TextfieldValidator.input(value),
      inputType: TextInputType.streetAddress,
      textFieldIsRequired: true,
    );
  }
}
