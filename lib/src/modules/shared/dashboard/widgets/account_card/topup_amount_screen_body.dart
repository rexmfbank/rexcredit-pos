import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/shared/dashboard/providers/dashboard_topup_provider.dart';
import 'package:rex_app/src/modules/shared/models/text_field_validator.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_elevated_button.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_text_field.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class TopupAmountScreenBody extends ConsumerWidget {
  const TopupAmountScreenBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        RexTextField(
          controller: ref.watch(dashboardTopUpProvider).amountController,
          obscureText: false,
          outerTitle: StringAssets.amount,
          showOuterTile: true,
          inputType: const TextInputType.numberWithOptions(decimal: true),
          validator: (value) => TextfieldValidator.topupAmount(value),
          hasInputFormat: true,
        ),
        RexElevatedButton(
          onPressed: () =>
              ref.read(dashboardTopUpProvider.notifier).addCardActions(context),
          buttonTitle: StringAssets.nextTextOnButton,
          backgroundColor: null,
        ),
      ],
    );
  }
}
