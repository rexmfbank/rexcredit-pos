// ignore_for_file: camel_case_types

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/shared/onboarding/onboard_business/business_llc/provider/llc_director_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_elevated_button.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class LLC_AddDirectorButton extends ConsumerWidget {
  const LLC_AddDirectorButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(left: 14.0, right: 14.0),
      child: RexElevatedButton(
        onPressed: () =>
            ref.read(llcDirectorProvider.notifier).validateInput(context),
        buttonTitle: StringAssets.saveAndContinueText,
        backgroundColor: null,
      ),
    );
  }
}
