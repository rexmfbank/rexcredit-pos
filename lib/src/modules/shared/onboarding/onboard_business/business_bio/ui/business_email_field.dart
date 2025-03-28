import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/shared/models/text_field_validator.dart';
import 'package:rex_app/src/modules/shared/onboarding/onboard_business/business_bio/provider/business_bio_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_text_field.dart';

class BusinessEmailField extends HookConsumerWidget {
  const BusinessEmailField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return RexTextField(
      outerTitle: 'Business Email',
      hintText: 'Enter email address for the business',
      controller: ref.watch(businessBioProvider).businessEmailController,
      obscureText: false,
      showOuterTile: true,
      textFieldIsRequired: true,
      validator: (value) => TextfieldValidator.email(value),
      inputType: TextInputType.emailAddress,
    );
  }
}
