import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_text_field.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

final frequencyList = ['Daily', 'Weekly', 'Monthly', 'Yearly'];

class SavePayFrequencyDropdown extends StatefulWidget {
  const SavePayFrequencyDropdown({super.key});

  @override
  State<SavePayFrequencyDropdown> createState() =>
      _SavePayFrequencyDropdownState();
}

class _SavePayFrequencyDropdownState extends State<SavePayFrequencyDropdown> {
  String dropdownValue = frequencyList.first;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              Text(
                StringAssets.selectFrequency,
                style: TextStyle(
                  color: AppColors.textBlack,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500
                ),
              ),
              Text(
                ' *',
                style: TextStyle(
                    color: AppColors.red,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500
                ),
              ),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: AppColors.rexBackground,
            borderRadius: BorderRadius.circular(14.0),
          ),
          child: DropdownButtonFormField(
            value: dropdownValue,
            items: frequencyList.map<DropdownMenuItem<String>>((e) {
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
            icon: const Icon(
              Icons.keyboard_arrow_down,
              size: 24,
            ),
          ),
        ),
      ],
    );
  }
}
