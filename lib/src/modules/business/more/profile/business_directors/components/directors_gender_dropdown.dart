import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/shared/onboarding/onboard_business/common/provider/add_director_state_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/utility_widget/rex_textfield_required_rich_text.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

List<String> get _genderList => ['Male', 'Female'];

class DirectorGenderDropdown extends ConsumerStatefulWidget {
  const DirectorGenderDropdown({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DirectorGenderDropdownState();
}

class _DirectorGenderDropdownState
    extends ConsumerState<DirectorGenderDropdown> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const RexTextFieldRichText(title1: StringAssets.gender),
        SizedBox(height: 10.ah),
        Container(
          decoration: BoxDecoration(
            color: AppColors.rexWhite,
            borderRadius: BorderRadius.circular(14.ar),
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
                  .read(addDirectorStateProvider.notifier)
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
      ],
    );
  }
}
