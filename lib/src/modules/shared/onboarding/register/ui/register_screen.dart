import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/shared/onboarding/get_started/ui/components/navigate_to_login_screen.dart';
import 'package:rex_app/src/modules/shared/onboarding/register/ui/components/register_button.dart';
import 'package:rex_app/src/modules/shared/onboarding/register/ui/components/register_bvn_field.dart';
import 'package:rex_app/src/modules/shared/onboarding/register/ui/components/register_email_field.dart';
import 'package:rex_app/src/modules/shared/onboarding/register/ui/components/register_first_name_field.dart';
import 'package:rex_app/src/modules/shared/onboarding/register/ui/components/register_middle_name_field.dart';
import 'package:rex_app/src/modules/shared/onboarding/register/ui/components/register_nin_field.dart';
import 'package:rex_app/src/modules/shared/onboarding/register/ui/components/register_number_field.dart';
import 'package:rex_app/src/modules/shared/onboarding/register/ui/components/register_surname_field.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class RegisterScreen extends ConsumerWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: const RexAppBar(
          step: StringAssets.emptyString,
          shouldHaveBackButton: false,
          title: StringAssets.createAccountTitle,
          subtitle: StringAssets.createAccountSubTitle,
        ),
        body: ListView(
          physics: const BouncingScrollPhysics(),
          children: const [
            SizedBox(height: 8.0),
            RegisterFirstNameField(),
            RegisterMiddleNameField(),
            RegisterSurnameField(),
            RegisterNumberField(),
            RegisterBvnField(),
            RegisterNINField(),
            RegisterEmailField(),
            RegisterButton(),
            NavigateToLoginScreen(),
          ],
        ),
      ),
    );
  }
}
