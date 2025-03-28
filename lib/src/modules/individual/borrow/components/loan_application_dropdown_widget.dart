import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_api/rex_api.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_custom_text_field.dart';
import 'package:rex_app/src/modules/shared/widgets/dropdown/rex_disabled_dropdown.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class LoanApplicationDropdownWidget extends ConsumerWidget {
  final String title;
  final String? selectedStatus;
  final AsyncValue<List<FetchLookupDataByCodeResponseData>?> dropdownDataList;
  final void Function(FetchLookupDataByCodeResponseData?) onChanged;

  const LoanApplicationDropdownWidget({
    super.key,
    required this.title,
    required this.selectedStatus,
    required this.dropdownDataList,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
            bottom: 8.0,
            top: 16.0,
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              title,
              style: const TextStyle(
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
            child: dropdownDataList.when(
              data: (statusData) {
                if (statusData == null || statusData.isEmpty) {
                  return const RexDisabledDropdown();
                }

                final selectedItem = statusData.firstWhereOrNull(
                  (item) => item.description == selectedStatus,
                );

                return DropdownButtonFormField(
                  value: selectedItem,
                  hint: const Text(StringAssets.selectAnOption),
                  items: statusData
                      .map<DropdownMenuItem<FetchLookupDataByCodeResponseData>>(
                        (item) => DropdownMenuItem(
                          value: item,
                          child: Text(item.description),
                        ),
                      )
                      .toList(),
                  onChanged: onChanged,
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
