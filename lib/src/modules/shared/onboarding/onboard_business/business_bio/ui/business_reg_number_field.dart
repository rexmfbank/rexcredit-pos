import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/shared/onboarding/onboard_business/business_bio/provider/business_bio_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_text_field.dart';

class BusinessRegNumberField extends HookConsumerWidget {
  const BusinessRegNumberField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return RexTextField(
      outerTitle: 'Business Registration number',
      hintText: 'Enter registration number',
      controller: ref.watch(businessBioProvider).businessRegNumberController,
      obscureText: false,
      showOuterTile: true,
      maxLines: 1,
      textFieldIsRequired: true,
      inputType: TextInputType.text,
    );
  }
}
