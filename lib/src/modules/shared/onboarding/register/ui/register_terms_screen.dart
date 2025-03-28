import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/shared/termsConditions/widgets/terms_and_conditions_widget.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class RegisterTermsScreen extends ConsumerWidget {
  const RegisterTermsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
