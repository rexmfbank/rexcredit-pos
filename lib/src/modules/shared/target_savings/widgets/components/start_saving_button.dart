import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/shared/target_savings/providers/target_saving_notifier.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_flat_button.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class StartSavingButton extends ConsumerWidget {
  const StartSavingButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.aw),
      child: RexFlatButton(
        onPressed: () {
          ref.read(targetSavingProvider.notifier).createSavingsForm(context);
        },
        buttonTitle: StringAssets.nextTextOnButton,
        backgroundColor: null,
      ),
    );
  }
}
