import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/business/more/profile/business_information/providers/business_info_screen_provider.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

final businessTypeList = [
  'Sole Proprietorship',
  'Limited Liability Company',
  'Partnership'
];

class BusinessTypeDropdown extends ConsumerStatefulWidget {
  const BusinessTypeDropdown({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _BusinessTypeDropdownState();
}

class _BusinessTypeDropdownState extends ConsumerState<BusinessTypeDropdown> {
  String dropdownValue = businessTypeList.first;
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
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              StringAssets.businessTypeRequiredTitle,
              style: TextStyle(
                  color: AppColors.rexPurpleDark, fontWeight: FontWeight.w500),
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
              value: dropdownValue,
              hint: const Text(StringAssets.selectAnOption),
              items: businessTypeList.map<DropdownMenuItem<String>>((e) {
                return DropdownMenuItem(
                  value: e,
                  child: Text(e),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  ref
                      .watch(businessInfoProvider.notifier)
                      .setSelectedBusinessType(value!);
                  dropdownValue = value;
                });
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
