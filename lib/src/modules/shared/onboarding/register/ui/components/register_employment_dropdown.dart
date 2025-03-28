import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:rex_api/rex_api.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/shared/onboarding/register/provider/register_provider.dart';
import 'package:rex_app/src/modules/shared/onboarding/register/provider/register_sub_providers.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_custom_text_field.dart';
import 'package:rex_app/src/modules/shared/widgets/dropdown/rex_disabled_dropdown.dart';
import 'package:rex_app/src/modules/shared/widgets/utility_widget/rex_textfield_required_rich_text.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class RegisterEmploymentDropdown extends ConsumerStatefulWidget {
  const RegisterEmploymentDropdown({super.key});

  @override
  ConsumerState<RegisterEmploymentDropdown> createState() =>
      _RegisterEmploymentDropdownState();
}

class _RegisterEmploymentDropdownState
    extends ConsumerState<RegisterEmploymentDropdown> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.refresh(fetchRegisterEmploymentStatusList);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final employmentTypeList = ref.watch(fetchRegisterEmploymentStatusList);
    //
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
            child: RexTextFieldRichText(
              title1: StringAssets.registerEmploy,
              color1: AppColors.rexPurpleDark,
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
            child: employmentTypeList.when(
              data: (employmentType) {
                return DropdownButtonFormField(
                  items: employmentType!
                      .map<DropdownMenuItem<FetchLookupDataByCodeResponseData>>(
                        (item) => DropdownMenuItem(
                          value: item,
                          child: Text(item.name),
                        ),
                      )
                      .toList(),
                  onChanged: (item) {
                    ref
                        .read(registerProvider.notifier)
                        .onEmploymentCategoryDropdownChange(item!.code);
                  },
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
