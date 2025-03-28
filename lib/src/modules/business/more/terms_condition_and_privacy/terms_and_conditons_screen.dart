import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/shared/termsConditions/provider/terms_and_privacy_policy_provider.dart';
import 'package:rex_app/src/modules/shared/termsConditions/widgets/terms_and_conditions_widget.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class BusinessTermsAndConditionsScreen extends ConsumerStatefulWidget {
  const BusinessTermsAndConditionsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _BusinessTermsAndConditionsScreen();
}

class _BusinessTermsAndConditionsScreen
    extends ConsumerState<BusinessTermsAndConditionsScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(termsAndPrivacyPolicyProvider.notifier)
          .getTermsConditionsAndPolicy();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: RexAppBar(
        step: null,
        shouldHaveBackButton: true,
        title: StringAssets.termsCondition1,
        subtitle: StringAssets.termsCondition2,
        hasActionButton: false,
      ),
      body: TermsAndConditionsWidget(),
    );
  }
}
