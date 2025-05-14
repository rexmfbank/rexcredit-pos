// ignore_for_file: camel_case_types

import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:rex_app/src/config/routes/route_name.dart';
import 'package:rex_app/src/modules/shared/onboarding/onboard_business/business_bio/ui/business_setup_later_text.dart';
import 'package:rex_app/src/modules/shared/onboarding/onboard_business/business_llc/provider/llc_doc_provider.dart';
import 'package:rex_app/src/modules/shared/onboarding/onboard_business/common/widgets/business_setup_header.dart';
import 'package:rex_app/src/modules/shared/onboarding/onboard_business/business_llc/ui/documents/llc_certificate_cac.dart';
import 'package:rex_app/src/modules/shared/onboarding/onboard_business/business_llc/ui/documents/llc_form_co2.dart';
import 'package:rex_app/src/modules/shared/onboarding/onboard_business/business_llc/ui/documents/llc_form_co7.dart';
import 'package:rex_app/src/modules/shared/onboarding/onboard_business/business_llc/ui/documents/llc_memorandum.dart';
import 'package:rex_app/src/modules/shared/onboarding/onboard_business/business_llc/ui/documents/llc_resolution_board.dart';
import 'package:rex_app/src/modules/shared/onboarding/onboard_business/business_llc/ui/documents/llc_utility_bill.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_elevated_button.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class LLC_DocScreen extends ConsumerWidget {
  const LLC_DocScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: RexAppBar(
        shouldHaveBackButton: true,
        step: StringAssets.thirdStep2,
        title: StringAssets.cacDocuments2,
        subtitle: StringAssets.cacDocuments3,
        onBackButtonPressed: () => context.go(Routes.businessBio),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          const BusinessSetupHeader(text: StringAssets.docHeaderLLC),
          const LLC_Certificate_CAC(),
          const LLC_Memorandum(),
          const LLC_FormCo7(),
          const LLC_FormCo2(),
          const LLC_ResolutionBoard(),
          const LLC_UtilityBill(),
          Padding(
            padding: const EdgeInsets.only(left: 14.0, right: 14.0),
            child: RexElevatedButton(
              onPressed: () =>
                  ref.read(llcDocProvider.notifier).validateDocuments(context),
              buttonTitle: StringAssets.saveAndContinueText,
              backgroundColor: null,
            ),
          ),
          const BusinessSetupLaterText(),
        ],
      ),
    );
  }
}
