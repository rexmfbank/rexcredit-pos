import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/config/routes/route_name.dart';
import 'package:rex_app/src/modules/shared/onboarding/onboard_business/business_bio/ui/business_lga_dropdown.dart';
import 'package:rex_app/src/modules/shared/onboarding/onboard_business/business_bio/ui/business_address_field.dart';
import 'package:rex_app/src/modules/shared/onboarding/onboard_business/business_bio/ui/business_email_field.dart';
import 'package:rex_app/src/modules/shared/onboarding/onboard_business/business_bio/ui/business_industry_dropdown.dart';
import 'package:rex_app/src/modules/shared/onboarding/onboard_business/business_bio/ui/business_logo_upload.dart';
import 'package:rex_app/src/modules/shared/onboarding/onboard_business/business_bio/ui/business_name_field.dart';
import 'package:rex_app/src/modules/shared/onboarding/onboard_business/business_bio/ui/business_number_field.dart';
import 'package:rex_app/src/modules/shared/onboarding/onboard_business/business_bio/ui/business_reg_number_field.dart';
import 'package:rex_app/src/modules/shared/onboarding/onboard_business/business_bio/ui/business_setup_button.dart';
import 'package:rex_app/src/modules/shared/onboarding/onboard_business/business_bio/ui/business_setup_later_text.dart';
import 'package:rex_app/src/modules/shared/onboarding/onboard_business/business_bio/ui/business_tax_no_field.dart';
import 'package:rex_app/src/modules/shared/onboarding/onboard_business/business_bio/ui/business_years_field.dart';
import 'package:rex_app/src/modules/shared/onboarding/onboard_business/business_bio/ui/business_state_dropdown.dart';
import 'package:rex_app/src/modules/shared/widgets/modal_bottom_sheets/show_modal_action.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class BusinessBioScreen extends ConsumerWidget {
  const BusinessBioScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: RexAppBar(
        step: StringAssets.thirdStep1,
        shouldHaveBackButton: true,
        title: StringAssets.completeBusinessSetup,
        subtitle: StringAssets.completeBusinessSubtitle,
        onBackButtonPressed: () => context.go(RouteName.accountType),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          const BusinessLogoUpload(),
          const BusinessNameField(),
          const BusinessEmailField(),
          const BusinessRegNumberField(),
          const BusinessTaxNoField(),
          const BusinessAddressField(),
          const BusinessIndustryDropdown(),
          const BusinessYearsField(),
          const BusinessNumberField(),
          SizedBox(height: 10.ah),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.aw),
            child: Row(
              children: [
                const Flexible(flex: 1, child: BusinessStateDropdown()),
                SizedBox(width: 19.aw),
                const Flexible(flex: 1, child: BusinessLgaDropdown()),
              ],
            ),
          ),
          SizedBox(height: 10.ah),
          const BusinessSetupButton(),
          const BusinessSetupLaterText(),
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
