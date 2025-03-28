import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/config/routes/route_name.dart';
import 'package:rex_app/src/modules/shared/termsConditions/provider/terms_and_privacy_policy_provider.dart';
import 'package:rex_app/src/modules/shared/onboarding/register/provider/register_provider.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class RegisterTermsAndCondition extends ConsumerWidget {
  const RegisterTermsAndCondition({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(registerProvider);
    //
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Checkbox(
          value: provider.termsAndCondition,
          onChanged: (bool? value) {
            ref.read(registerProvider.notifier).onCheckBoxChanged(value!);
          },
        ),
        GestureDetector(
          onTap: () {
            ref
                .read(termsAndPrivacyPolicyProvider.notifier)
                .getTermsConditionsAndPolicy();
            context.push(RouteName.registerTerms);
          },
          child: const Text(
            StringAssets.termsConditionAccept,
            style: TextStyle(
              decoration: TextDecoration.underline,
              decorationStyle: TextDecorationStyle.solid,
            ),
          ),
        ),
      ],
    );
  }
}
