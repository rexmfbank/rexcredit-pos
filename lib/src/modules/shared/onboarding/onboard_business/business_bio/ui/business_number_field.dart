import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/shared/models/text_field_validator.dart';
import 'package:rex_app/src/modules/shared/onboarding/onboard_business/business_bio/provider/business_bio_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_text_field.dart';

class BusinessNumberField extends HookConsumerWidget {
  const BusinessNumberField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return RexTextField(
      outerTitle: 'Phone number',
      hintText: 'Enter phone number',
      controller: ref.watch(businessBioProvider).businessPhoneController,
      obscureText: false,
      showOuterTile: true,
      maxLength: 11,
      validator: (value) => TextfieldValidator.phoneNumber(value),
      inputType: TextInputType.number,
      textFieldIsRequired: true,
    );
  }
}
