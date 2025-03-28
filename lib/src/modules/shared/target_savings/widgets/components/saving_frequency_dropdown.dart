import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/shared/target_savings/providers/target_saving_notifier.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_rich_text.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

final _frequency = ['Daily', 'Weekly', 'Monthly', 'Yearly'];

class SavingFrequencyDropdown extends ConsumerStatefulWidget {
  const SavingFrequencyDropdown({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SavingFrequencyDropdownState();
}

class _SavingFrequencyDropdownState
    extends ConsumerState<SavingFrequencyDropdown> {
  String dropdownValue = _frequency.first;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Padding(
          padding: EdgeInsets.only(
            left: 16.0,
            bottom: 8.0,
            top: 8.0,
          ),
          child: RexRichText(
            title1: StringAssets.saveFrequencyTitle,
            title2: ' *',
            alignment: Alignment.centerLeft,
            textDecoration2: TextDecoration.none,
            color2: AppColors.red,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.aw),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.rexWhite,
              borderRadius: BorderRadius.circular(14.ar),
            ),
            child: DropdownButtonFormField(
              value: null,
              hint: const Text(StringAssets.selectAnOptionCaps),
              items: _frequency.map<DropdownMenuItem<String>>((e) {
                return DropdownMenuItem(
                  value: e,
                  child: Text(e),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  dropdownValue = value!;
                });
                ref
                    .read(targetSavingProvider.notifier)
                    .setSavingFrequency(value);
              },
              decoration: InputDecoration(
                focusColor: Colors.black,
                border: AppConstants.rexInputBorder,
                enabledBorder: AppConstants.rexInputBorder,
                focusedBorder: AppConstants.rexInputBorder,
              ),
              isExpanded: true,
            ),
          ),
        ),
      ],
    );
  }
}
