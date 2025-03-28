import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/shared/onboarding/onboard_business/business_bio/provider/business_bio_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_text_field.dart';

class BusinessTaxNoField extends HookConsumerWidget {
  const BusinessTaxNoField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return RexTextField(
      outerTitle: 'Business Tax number',
      hintText: 'Enter tax number for the business',
      showOuterTile: true,
      controller: ref.watch(businessBioProvider).businessTaxController,
      obscureText: false,
      maxLines: 1,
      inputType: TextInputType.text,
      textFieldIsRequired: true,
    );
  }
}
