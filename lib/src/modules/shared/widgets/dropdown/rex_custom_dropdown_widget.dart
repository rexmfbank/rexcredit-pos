import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_custom_text_field.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class RexCustomDropdownWidget extends ConsumerWidget {
  final String title;
  final String? selectedStatus;
  final List<String> dropdownDataList;
  final void Function(String?) onChanged;

  const RexCustomDropdownWidget({
    super.key,
    required this.title,
    required this.selectedStatus,
    required this.dropdownDataList,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedItem = dropdownDataList.firstWhereOrNull(
      (item) => item == selectedStatus,
    );
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
            child: DropdownButtonFormField(
              value: selectedItem,
              hint: const Text(StringAssets.selectAnOption),
              items: dropdownDataList
                  .map<DropdownMenuItem<String>>(
                    (item) => DropdownMenuItem(
                      value: item,
                      child: Text(item),
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
            ),
          ),
        ),
      ],
    );
  }
}
