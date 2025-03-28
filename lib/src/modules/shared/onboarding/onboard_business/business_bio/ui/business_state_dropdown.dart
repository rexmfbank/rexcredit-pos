import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/business/more/profile/business_information/providers/business_info_screen_provider.dart';
import 'package:rex_app/src/modules/shared/onboarding/onboard_business/business_bio/provider/business_bio_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_rich_text.dart';
import 'package:rex_app/src/modules/shared/widgets/dropdown/custom_dropdown_button.dart';
import 'package:rex_app/src/utils/constants/app_text_styles.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class BusinessStateDropdown extends ConsumerStatefulWidget {
  const BusinessStateDropdown({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _BusinessStateDropdownState();
}

class _BusinessStateDropdownState extends ConsumerState<BusinessStateDropdown> {
  @override
  void initState() {
    ref.read(businessBioProvider.notifier).initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        RexRichText(
          title1: StringAssets.state,
          textStyle1: AppTextStyles.body2Regular.copyWith(
            fontWeight: FontWeight.w500,
            color: AppColors.rexPurpleDark,
          ),
          title2: ' *',
          textDecoration2: TextDecoration.none,
          color2: AppColors.red,
          alignment: Alignment.centerLeft,
        ),
        SizedBox(height: 5.ah),
        CustomDropDownButton(
          height: 56.ah,
          items: (ref.watch(businessBioProvider).stateLgaResponse == null ||
                  ref.watch(businessBioProvider).stateLgaResponse!.isEmpty)
              ? []
              : ref
                  .watch(businessBioProvider)
                  .stateLgaResponse!
                  .map((e) => e.state.name)
                  .toList(),
          backGroundColor: AppColors.rexWhite,
          dropdownValue:
              ValueNotifier(ref.watch(businessBioProvider).businessState),
          withHint: false,
          onChanged: (String? value) {
            ref.watch(businessInfoProvider.notifier).updateSelectedState(value);
            ref.watch(businessBioProvider.notifier).updateSelectedState(value);
          },
        ),
      ],
    );
  }
}
