import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/shared/onboarding/onboard_business/business_bio/provider/business_bio_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_text_field.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class BusinessYearsField extends HookConsumerWidget {
  const BusinessYearsField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return RexTextField(
      outerTitle: StringAssets.bizTextTitle1,
      hintText: StringAssets.bizTextTitle2,
      controller: ref.watch(businessBioProvider).businessYearsController,
      obscureText: false,
      showOuterTile: true,
      textFieldIsRequired: true,
      inputType: TextInputType.number,
    );
  }
}
