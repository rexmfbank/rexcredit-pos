import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/shared/onboarding/onboard_individual/providers/complete_setup_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_rich_text.dart';
import 'package:rex_app/src/utils/constants/app_text_styles.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

List<String> get _genderList => ['Male', 'Female'];

class CompleteSetupGenderDropdown extends ConsumerStatefulWidget {
  const CompleteSetupGenderDropdown({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CompleteSetupGenderDropdownState();
}

class _CompleteSetupGenderDropdownState
    extends ConsumerState<CompleteSetupGenderDropdown> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 16.aw, top: 8.ah),
          child: RexRichText(
            title1: StringAssets.gender,
            textStyle1: AppTextStyles.body2Regular.copyWith(
              fontWeight: FontWeight.w500,
              color: AppColors.rexPurpleDark,
            ),
            title2: ' *',
            textDecoration2: TextDecoration.none,
            color2: AppColors.red,
            alignment: Alignment.centerLeft,
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
              items: _genderList.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? value) {
                ref
                    .read(completeSetupProvider.notifier)
                    .onGenderDropdownChange(value);
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
