import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/shared/onboarding/onboard_business/business_bio/provider/business_bio_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_text_field.dart';

class BusinessAddressField extends HookConsumerWidget {
  const BusinessAddressField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return RexTextField(
      outerTitle: 'Business Address',
      hintText: 'Enter address',
      controller: ref.watch(businessBioProvider).businessAddressController,
      obscureText: false,
      showOuterTile: true,
      textFieldIsRequired: true,
      inputType: TextInputType.text,
    );
  }
}
