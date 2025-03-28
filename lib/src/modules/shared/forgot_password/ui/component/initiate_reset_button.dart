import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/shared/forgot_password/provider/initiate_password_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_flat_button.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class InitiateResetButton extends ConsumerWidget {
  const InitiateResetButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
      child: RexFlatButton(
        onPressed: () {
          ref
              .read(initiatePasswordProvider.notifier)
              .initiatePasswordReset(context);
        },
        buttonTitle: StringAssets.nextTextOnButton,
        backgroundColor: null,
      ),
    );
  }
}
