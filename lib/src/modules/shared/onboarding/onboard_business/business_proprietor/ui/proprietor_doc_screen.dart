import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/config/routes/route_name.dart';
import 'package:rex_app/src/modules/shared/onboarding/onboard_business/business_bio/ui/business_setup_later_text.dart';
import 'package:rex_app/src/modules/shared/onboarding/onboard_business/business_proprietor/provider/proprietor_doc_provider.dart';
import 'package:rex_app/src/modules/shared/onboarding/onboard_business/business_proprietor/ui/proprietor_cac_apply.dart';
import 'package:rex_app/src/modules/shared/onboarding/onboard_business/business_proprietor/ui/proprietor_cac_cert.dart';
import 'package:rex_app/src/modules/shared/onboarding/onboard_business/business_proprietor/ui/proprietor_utility_bill.dart';
import 'package:rex_app/src/modules/shared/onboarding/onboard_business/common/widgets/business_setup_header.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_elevated_button.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class ProprietorDocScreen extends ConsumerWidget {
  const ProprietorDocScreen({super.key});

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
          const BusinessSetupHeader(text: StringAssets.docHeaderSole),
          const ProprietorUtilityBill(),
          const ProprietorCacCert(),
          const ProprietorCacApply(),
          Padding(
            padding: const EdgeInsets.only(left: 14.0, right: 14.0),
            child: RexElevatedButton(
              onPressed: () => ref
                  .read(proprietorDocProvider.notifier)
                  .validateDocuments(context),
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
