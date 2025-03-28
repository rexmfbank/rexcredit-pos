import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/shared/fixed_deposit/providers/fixed_deposit_notifier.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_flat_button.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class DepositStartButton extends ConsumerWidget {
  const DepositStartButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
      child: RexFlatButton(
        onPressed: () {
          ref.read(fixedDepositProvider.notifier).createDepositForm(context);
        },
        buttonTitle: StringAssets.nextTextOnButton,
        backgroundColor: null,
      ),
    );
  }
}
