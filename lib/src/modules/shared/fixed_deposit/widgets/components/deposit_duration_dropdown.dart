import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/shared/fixed_deposit/providers/deposit_providers.dart';
import 'package:rex_app/src/modules/shared/fixed_deposit/providers/fixed_deposit_notifier.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_custom_text_field.dart';
import 'package:rex_app/src/modules/shared/widgets/dropdown/rex_disabled_dropdown.dart';

class DepositDurationDropdown extends ConsumerWidget {
  const DepositDurationDropdown({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final durations = ref.watch(fetchFixedDepositDurations);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Padding(
          padding: EdgeInsets.only(
            left: 16.0,
            bottom: 8.0,
            top: 8.0,
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Select duration',
              style: TextStyle(
                color: AppColors.rexPurpleDark,
                fontWeight: FontWeight.w500,
                fontSize: 15.0,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.rexWhite,
              borderRadius: BorderRadius.circular(14.0),
            ),
            child: durations.when(
              data: (depositType) {
                return DropdownButtonFormField(
                  value: null,
                  hint: const Text('Select option'),
                  items: depositType!
                      .map<DropdownMenuItem<String>>((item) => DropdownMenuItem(
                            value: item,
                            child: Text("$item days"),
                          ))
                      .toList(),
                  onChanged: (value) {
                    ref
                        .read(fixedDepositProvider.notifier)
                        .onDurationDropdownChange(value);
                  },
                  decoration: InputDecoration(
                    focusColor: Colors.black,
                    border: rexInputBorder,
                    enabledBorder: rexInputBorder,
                    focusedBorder: rexInputBorder,
                  ),
                  isExpanded: true,
                );
              },
              loading: () => const RexDisabledDropdown(),
              error: (error, stackTrace) => const RexDisabledDropdown(),
            ),
          ),
        ),
      ],
    );
  }
}
