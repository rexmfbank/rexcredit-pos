import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/individual/borrow/providers/loan_application_provider.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

final statusList = ['Fulltime', 'Part-time', 'Contract'];

class EmployerStatusDropdown extends ConsumerStatefulWidget {
  const EmployerStatusDropdown({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EmployerStatusDropdownState();
}

class _EmployerStatusDropdownState
    extends ConsumerState<EmployerStatusDropdown> {
  String dropdownValue = statusList.first;
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
              StringAssets.employmentStatusTitle,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 15.0,
                color: AppColors.rexPurpleDark,
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
              items: statusList.map<DropdownMenuItem<String>>((e) {
                return DropdownMenuItem(
                  value: e,
                  child: Text(e),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  dropdownValue = value!;
                  ref
                      .read(loanApplicationProvider.notifier)
                      .setSelectedEmploymentType(value);
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
        )
      ],
    );
  }
}
