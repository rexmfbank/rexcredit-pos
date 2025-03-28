import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/shared/onboarding/onboard_business/business_bio/provider/business_bio_provider.dart';
import 'package:rex_app/src/utils/constants/constants.dart';

List<String> get _businessTypeList => [
      'Partnership',
      'Limited Liability Company',
      'Sole Proprietorship',
      'Cooperative Society',
    ];

class BusinessTypeDropdown extends ConsumerStatefulWidget {
  const BusinessTypeDropdown({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _BusinessTypeDropdownState();
}

class _BusinessTypeDropdownState extends ConsumerState<BusinessTypeDropdown> {
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
              'Select a business type',
              style: TextStyle(
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
              items: _businessTypeList.map<DropdownMenuItem<String>>((e) {
                return DropdownMenuItem(
                  value: e,
                  child: Text(e),
                );
              }).toList(),
              onChanged: (value) {
                ref
                    .read(businessBioProvider.notifier)
                    .onBusinessTypeDropdownChange(value);
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
