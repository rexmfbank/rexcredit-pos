import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/utils/constants/constants.dart';

final idCardList = ['Plan 1', 'Plan 2', 'Plan 3'];

class BusinessIdCardDropdown extends ConsumerStatefulWidget {
  const BusinessIdCardDropdown({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _BusinessIdCardDropdownState();
}

class _BusinessIdCardDropdownState
    extends ConsumerState<BusinessIdCardDropdown> {
  String dropdownValue = idCardList.first;
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
              'ID card type',
              style: TextStyle(
                color: AppColors.rexPurpleDark,
                fontSize: 15.0,
                fontWeight: FontWeight.w500,
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
              value: dropdownValue,
              items: idCardList.map<DropdownMenuItem<String>>((e) {
                return DropdownMenuItem(
                  value: e,
                  child: Text(e),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  dropdownValue = value!;
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
