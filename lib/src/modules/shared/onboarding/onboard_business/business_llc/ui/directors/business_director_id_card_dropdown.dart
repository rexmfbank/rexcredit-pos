import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/shared/widgets/utility_widget/rex_textfield_required_rich_text.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

final businessIdCardList = [
  'Driver\'s License',
  'National ID',
  'International Passport'
];

class BusinessDirectorIdCardDropdown extends ConsumerStatefulWidget {
  const BusinessDirectorIdCardDropdown({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _BusinessDirectorIdCardDropdownState();
}

class _BusinessDirectorIdCardDropdownState
    extends ConsumerState<BusinessDirectorIdCardDropdown> {
  String dropdownValue = businessIdCardList.first;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const RexTextFieldRichText(title1: StringAssets.idCardTitle),
        SizedBox(height: 10.ah),
        Container(
          decoration: BoxDecoration(
            color: AppColors.rexWhite,
            borderRadius: BorderRadius.circular(14.0),
          ),
          child: DropdownButtonFormField(
            value: dropdownValue,
            items: businessIdCardList.map<DropdownMenuItem<String>>((e) {
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
      ],
    );
  }
}
