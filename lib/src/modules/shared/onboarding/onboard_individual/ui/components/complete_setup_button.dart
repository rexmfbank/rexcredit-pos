import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/shared/onboarding/onboard_individual/providers/complete_setup_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_elevated_button.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class CompleteSetupButton extends ConsumerWidget {
  const CompleteSetupButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.aw),
      child: RexElevatedButton(
        onPressed: () {
          ref.read(completeSetupProvider.notifier).validate(context);
        },
        backgroundColor: null,
        buttonTitle: StringAssets.continueTextOnButton,
      ),
    );
  }
}
