import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/shared/onboarding/onboard_business/business_bio/provider/business_bio_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_elevated_button.dart';

class BusinessSetupButton extends ConsumerWidget {
  const BusinessSetupButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(left: 14.0, right: 14.0),
      child: RexElevatedButton(
        onPressed: () => ref
            .watch(businessBioProvider.notifier)
            .validateInputAndSubmit(context),
        buttonTitle: 'Save & Continue',
        backgroundColor: null,
      ),
    );
  }
}
