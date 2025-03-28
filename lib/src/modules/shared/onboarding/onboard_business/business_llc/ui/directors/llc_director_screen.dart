// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/config/routes/route_name.dart';
import 'package:rex_app/src/modules/shared/onboarding/onboard_business/business_bio/provider/business_bio_provider.dart';
import 'package:rex_app/src/modules/shared/onboarding/onboard_business/business_bio/provider/business_logo_provider.dart';
import 'package:rex_app/src/modules/shared/onboarding/onboard_business/business_llc/provider/llc_director_provider.dart';
import 'package:rex_app/src/modules/shared/onboarding/onboard_business/business_llc/provider/llc_doc_provider.dart';
import 'package:rex_app/src/modules/shared/onboarding/onboard_business/business_llc/ui/directors/llc_add_director_button.dart';
import 'package:rex_app/src/modules/shared/onboarding/onboard_business/business_llc/ui/directors/llc_director1_form.dart';
import 'package:rex_app/src/modules/shared/onboarding/onboard_business/business_llc/ui/directors/llc_director2_form.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class LLC_DirectorScreen extends ConsumerStatefulWidget {
  const LLC_DirectorScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _LLC_DirectorScreenState();
}

class _LLC_DirectorScreenState extends ConsumerState<LLC_DirectorScreen> {
  @override
  void dispose() {
    ref.invalidate(businessBioProvider);
    ref.invalidate(businessLogoProvider);
    ref.invalidate(llcDocProvider);
    ref.invalidate(llcDirectorProvider);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RexAppBar(
        step: StringAssets.thirdStep3,
        shouldHaveBackButton: true,
        title: StringAssets.addDirectorTitle,
        subtitle: StringAssets.addDirectorRequired,
        onBackButtonPressed: () => context.go(RouteName.bizllcDocs),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: const [
          LLC_Director1Form(),
          LLC_Director2Form(),
          // Padding(
          //   padding: EdgeInsets.symmetric(horizontal: 14.aw),
          //   child: RexElevatedButton(
          //     onPressed: () {},
          //     buttonTitle: StringAssets.addAnotherDirector,
          //     backgroundColor: AppColors.rexLightBlue3,
          //   ),
          // ),
          LLC_AddDirectorButton(),
        ],
      ),
    );
  }
}
