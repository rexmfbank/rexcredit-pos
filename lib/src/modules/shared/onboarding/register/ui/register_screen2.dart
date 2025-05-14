import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:rex_app/src/config/routes/route_name.dart';
import 'package:rex_app/src/modules/shared/onboarding/register/ui/components/register_terms_condition.dart';
import 'package:rex_app/src/modules/shared/onboarding/register/ui/components/register_birth_date.dart';
import 'package:rex_app/src/modules/shared/onboarding/register/ui/components/register_button2.dart';
import 'package:rex_app/src/modules/shared/onboarding/register/ui/components/register_employment_dropdown.dart';
import 'package:rex_app/src/modules/shared/onboarding/register/ui/components/register_income_range_dropdown.dart';
import 'package:rex_app/src/modules/shared/onboarding/register/ui/components/register_password_confirm_field.dart';
import 'package:rex_app/src/modules/shared/onboarding/register/ui/components/register_password_field.dart';
import 'package:rex_app/src/modules/shared/onboarding/register/ui/components/register_username_field.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class RegisterScreen2 extends ConsumerWidget {
  const RegisterScreen2({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: RexAppBar(
        step: StringAssets.emptyString,
        shouldHaveBackButton: true,
        title: StringAssets.createAccountTitle,
        subtitle: StringAssets.createAccountSubTitle,
        onBackButtonPressed: () {
          context.go(Routes.register);
        },
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: const [
          RegisterBirthDate(),
          RegisterUsernameField(),
          RegisterPasswordField(),
          RegisterPasswordConfirmField(),
          RegisterEmploymentDropdown(),
          RegisterIncomeRangeDropdown(),
          RegisterTermsAndCondition(),
          RegisterButton2(),
        ],
      ),
    );
  }
}
