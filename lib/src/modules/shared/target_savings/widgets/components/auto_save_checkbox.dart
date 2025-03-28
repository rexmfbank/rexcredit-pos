import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/shared/target_savings/providers/target_saving_notifier.dart';
import 'package:rex_app/src/modules/shared/widgets/custom_checked_box.dart';

class AutoSaveCheckbox extends ConsumerWidget {
  const AutoSaveCheckbox({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final savingState = ref.watch(targetSavingProvider);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Do you want to auto-save?',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14.0,
                color: AppColors.rexPurpleDark,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16.0, left: 8.0, right: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                fit: FlexFit.loose,
                child: CustomCheckedBoxWidget(
                  text: 'Yes',
                  isChecked: savingState.isYesChecked!,
                  onChanged: (bool? isCheckedValue) {
                    ref
                        .read(targetSavingProvider.notifier)
                        .onChangeYesCheck(isCheckedValue);
                  },
                ),
              ),
              Flexible(
                fit: FlexFit.loose,
                child: CustomCheckedBoxWidget(
                  text: 'No',
                  isChecked: savingState.isNoChecked!,
                  onChanged: (isChecked) {
                    ref
                        .read(targetSavingProvider.notifier)
                        .onChangeNoCheck(isChecked);
                  },
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
