import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rex_app/src/config/routes/route_name.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/shared/onboarding/onboard_individual/providers/complete_setup_provider.dart';
import 'package:rex_app/src/modules/shared/onboarding/onboard_individual/ui/components/complete_setup_address_field.dart';
import 'package:rex_app/src/modules/shared/onboarding/onboard_individual/ui/components/complete_setup_button.dart';
import 'package:rex_app/src/modules/shared/onboarding/onboard_individual/ui/components/complete_setup_gender_dropdown.dart';
import 'package:rex_app/src/modules/shared/onboarding/onboard_individual/ui/components/complete_setup_lga_dropdown.dart';
import 'package:rex_app/src/modules/shared/onboarding/onboard_individual/ui/components/complete_setup_referral_field.dart';
import 'package:rex_app/src/modules/shared/onboarding/onboard_individual/ui/components/complete_setup_state_dropdown.dart';
import 'package:rex_app/src/modules/shared/widgets/modal_bottom_sheets/show_modal_action.dart';
import 'package:rex_app/src/modules/shared/widgets/page_widgets/app_scaffold.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CompleteSetupScreen extends ConsumerWidget {
  const CompleteSetupScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppScaffold(
      isLoading: ref.watch(completeSetupProvider).isLoading,
      backgroundColor: AppColors.rexBackgroundGrey,
      padding: EdgeInsets.zero,
      appBar: RexAppBar(
        step: StringAssets.emptyString,
        shouldHaveBackButton: true,
        title: StringAssets.completeSetupTitle,
        subtitle: StringAssets.completeSetupSubtitle,
        onBackButtonPressed: () => context.go(Routes.accountType),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          SizedBox(height: 8.ah),
          const CompleteSetupAddressField(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.aw),
            child: Row(
              children: [
                const Flexible(flex: 1, child: CompleteSetupStateDropdown()),
                SizedBox(width: 19.aw),
                const Flexible(flex: 1, child: CompleteSetupLGADropdown()),
              ],
            ),
          ),
          const CompleteSetupGenderDropdown(),
          SizedBox(height: 12.ah),
          const CompleteSetupReferralField(),
          SizedBox(height: 32.ah),
          const CompleteSetupButton(),
        ],
      ),
    );
  }

  Future<bool> onWillPopScope(BuildContext context) async {
    showExitModal(
      context: context,
      subtitle: StringAssets.cantExitThisProcess,
    );
    return false;
  }
}
