import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/shared/target_savings/providers/target_saving_notifier.dart';
import 'package:rex_app/src/modules/shared/target_savings/widgets/components/show_fund_saving_topup.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_elevated_button.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_text_field.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class TopupSavingWidget extends ConsumerWidget {
  const TopupSavingWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final targetSavingState = ref.watch(targetSavingProvider);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        RexTextField(
          outerTitle: StringAssets.enterAmount,
          showOuterTile: true,
          controller: targetSavingState.topupController,
          inputType: const TextInputType.numberWithOptions(decimal: true),
          hasInputFormat: true,
          textFieldIsRequired: true,
        ),
        targetSavingState.topupSavingInputValidation
            ? const InvalidInputText()
            : Container(),
        Padding(
          padding: const EdgeInsets.only(left: 12.0, right: 12.0),
          child: RexElevatedButton(
            onPressed: () {
              if (ref
                  .read(targetSavingProvider.notifier)
                  .validateTopupSavingInput()) {
                ref
                    .read(targetSavingProvider.notifier)
                    .setTopupSavingInputValidation(true);
              } else {
                ref
                    .read(targetSavingProvider.notifier)
                    .setTopupSavingInputValidation(false);
                showFundSavingTopup(context: context);
              }
            },
            buttonTitle: StringAssets.fundRegularSavingsPlanTextOnButton,
          ),
        ),
      ],
    );
  }
}

class InvalidInputText extends StatelessWidget {
  const InvalidInputText({super.key});

  @override
  Widget build(BuildContext context) => const Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: EdgeInsets.only(left: 12.0),
          child: Text(
            StringAssets.invalidInput,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: AppColors.red,
            ),
          ),
        ),
      );
}
