import 'package:flutter/material.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/shared/onboarding/onboard_individual/providers/complete_setup_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_rich_text.dart';
import 'package:rex_app/src/modules/shared/widgets/dropdown/custom_dropdown_button.dart';
import 'package:rex_app/src/utils/constants/app_text_styles.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';
import 'package:rex_app/src/utils/extensions/extension_on_string.dart';

class CompleteSetupLGADropdown extends ConsumerWidget {
  const CompleteSetupLGADropdown({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final completeSetup = ref.watch(completeSetupProvider);
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
          backGroundColor: AppColors.rexWhite,
          items: completeSetup.state.isBlank
              ? []
              : completeSetup.stateLgaResponse!
                  .firstWhere(
                      (element) => element.state.name == completeSetup.state)
                  .state
                  .locals,
          dropdownValue: ValueNotifier(completeSetup.lga),
          withHint: false,
          onChanged: (value) => ref
              .watch(completeSetupProvider.notifier)
              .updateSelectedCity(value),
        ),
      ],
    );
  }
}
