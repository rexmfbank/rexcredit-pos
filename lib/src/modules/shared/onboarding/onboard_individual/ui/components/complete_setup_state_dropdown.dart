import 'package:flutter/material.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/shared/onboarding/onboard_individual/providers/complete_setup_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_rich_text.dart';
import 'package:rex_app/src/modules/shared/widgets/dropdown/custom_dropdown_button.dart';
import 'package:rex_app/src/utils/constants/app_text_styles.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class CompleteSetupStateDropdown extends ConsumerStatefulWidget {
  const CompleteSetupStateDropdown({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CompleteSetupStateDropdownState();
}

class _CompleteSetupStateDropdownState
    extends ConsumerState<CompleteSetupStateDropdown> {
  @override
  void initState() {
    super.initState();
    ref.read(completeSetupProvider.notifier).initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
          items: (ref.watch(completeSetupProvider).stateLgaResponse == null ||
                  ref.watch(completeSetupProvider).stateLgaResponse!.isEmpty)
              ? []
              : ref
                  .watch(completeSetupProvider)
                  .stateLgaResponse!
                  .map((e) => e.state.name)
                  .toList(),
          backGroundColor: AppColors.rexWhite,
          withHint: false,
          dropdownValue: ValueNotifier(ref.watch(completeSetupProvider).state),
          onChanged: (String? value) => ref
              .watch(completeSetupProvider.notifier)
              .updateSelectedState(value),
        ),
      ],
    );
  }
}
