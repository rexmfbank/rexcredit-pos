import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/shared/target_savings/providers/target_saving_notifier.dart';
import 'package:rex_app/src/modules/shared/models/text_field_validator.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_rich_text.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_text_field.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class AutoSaveWidget extends ConsumerWidget {
  const AutoSaveWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final savingState = ref.watch(targetSavingProvider);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 20.0),
          child: RexRichText(
            title1: StringAssets.startSaving1,
            title2: '*',
            textDecoration2: TextDecoration.none,
            color2: AppColors.red,
            alignment: Alignment.centerLeft,
          ),
        ),
        GestureDetector(
          onTap: () {
            showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime(2100),
            ).then((selectedDate) {
              ref
                  .read(targetSavingProvider.notifier)
                  .onChangeDateTime(selectedDate);
            });
          },
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            margin: const EdgeInsets.only(left: 16, right: 16, top: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              savingState.selectedDate == null
                  ? StringAssets.selectDate
                  : ref.watch(targetSavingProvider.notifier).formatDate(),
              style: const TextStyle(color: AppColors.rexTint500),
            ),
          ),
        ),
        const SizedBox(height: 8.0),
        RexTextField(
          controller: savingState.recurringAmountController,
          obscureText: false,
          showOuterTile: true,
          hasInputFormat: true,
          inputType: const TextInputType.numberWithOptions(decimal: true),
          outerTitle: StringAssets.startSaving2,
          validator: (value) => TextfieldValidator.savingsAmount2(value),
          textFieldIsRequired: true,
        ),
      ],
    );
  }
}
