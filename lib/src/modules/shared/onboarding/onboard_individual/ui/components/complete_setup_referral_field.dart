import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/shared/onboarding/onboard_individual/providers/complete_setup_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_text_field.dart';

class CompleteSetupReferralField extends ConsumerWidget {
  const CompleteSetupReferralField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(completeSetupProvider);

    return RexTextField(
      controller: provider.referralCodeController,
      showOuterTile: true,
      outerTitle: 'Referral code',
      inputType: TextInputType.text,
      obscureText: false,
    );
  }
}
