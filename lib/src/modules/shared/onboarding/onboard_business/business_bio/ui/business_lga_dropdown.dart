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
import 'package:rex_app/src/utils/extensions/extension_on_string.dart';

class BusinessLgaDropdown extends ConsumerWidget {
  const BusinessLgaDropdown({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        RexRichText(
          title1: StringAssets.lga,
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
            items: ref.watch(businessBioProvider).businessState.isBlank
                ? []
                : ref
                    .watch(businessBioProvider)
                    .stateLgaResponse!
                    .firstWhere((element) =>
                        element.state.name ==
                        ref.watch(businessBioProvider).businessState)
                    .state
                    .locals,
            backGroundColor: AppColors.rexWhite,
            dropdownValue:
                ValueNotifier(ref.watch(businessBioProvider).businessLGA),
            withHint: false,
            onChanged: (String? value) {
              ref
                  .watch(businessInfoProvider.notifier)
                  .updateSelectedCity(value);
              ref.watch(businessBioProvider.notifier).updateSelectedLGA(value);
            }),
      ],
    );
  }
}
