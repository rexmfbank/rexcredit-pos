import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/newProfile/provider/change_password_api_provider.dart';
import 'package:rex_app/src/modules/revamp/utils/theme/app_colors.dart';
import 'package:rex_app/src/modules/revamp/utils/app_password_rules.dart';
import 'package:rex_app/src/modules/shared/models/text_field_validator.dart';
import 'package:rex_app/src/modules/shared/widgets/page_widgets/app_scaffold.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_elevated_button.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_text_field_password.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class ChangePasswordScreen extends ConsumerStatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends ConsumerState<ChangePasswordScreen> {
  //bool currentPassword = true;
  //bool newPassword = true;
  //bool confirmPassword = true;

  @override
  Widget build(BuildContext context) {
    final screenProvider = ref.watch(changePasswordApiProvider);
    final rules = validatePassword2(screenProvider.newPassField);
    //
    return AppScaffold(
      isLoading: screenProvider.isLoading,
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.rexBackgroundGrey,
      appBar: RexAppBar(
        step: '',
        shouldHaveBackButton: true,
        title: Strings.changePasswordTitle,
        subtitle: Strings.changePasswordSubtitle,
        onBackButtonPressed: () {},
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          SizedBox(height: 20.ah),
          RexTextFieldPassword(
            outerTitle: Strings.changePasswordText1,
            hintText: Strings.passwordCurrentHint,
            controller: screenProvider.currentPassController,
            validator: (value) => TextfieldValidator.input(value),
            verticalPadding: 0,
            horizontalPadding: 0,
            //obscureText: currentPassword,
            // onPressed: () {
            //   setState(() => currentPassword = !currentPassword);
            // },
          ),
          SizedBox(height: 20.ah),
          RexTextFieldPassword(
            outerTitle: Strings.changePasswordText2,
            hintText: Strings.passwordNewHint,
            controller: screenProvider.newPassController,
            verticalPadding: 0,
            //obscureText: newPassword,
            horizontalPadding: 0,
            // onPressed: () {
            //   setState(() => newPassword = !newPassword);
            // },
            onChanged:
                (p0) => ref
                    .read(changePasswordApiProvider.notifier)
                    .onChangeNewPasswordField(p0),
          ),
          ...rules.map(
            (rule) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: PasswordRuleItem2(rule),
            ),
          ),
          SizedBox(height: 20.ah),
          RexTextFieldPassword(
            outerTitle: Strings.changePasswordText3,
            hintText: Strings.passwordNewConfirmHint,
            controller: screenProvider.confirmPassController,
            validator:
                (value) => TextfieldValidator.newConfirmPassword(
                  value: value,
                  password: screenProvider.newPassController.text,
                ),
            verticalPadding: 0,
            horizontalPadding: 0,
            //obscureText: confirmPassword,
            // onPressed: () {
            //   setState(() => confirmPassword = !confirmPassword);
            // },
          ),
          SizedBox(height: 32.ah),
          RexElevatedButton(
            onPressed: () {
              ref
                  .read(changePasswordApiProvider.notifier)
                  .changePassword(context);
            },
            buttonTitle: Strings.updateTextOnButton,
            backgroundColor: null,
          ),
        ],
      ),
    );
  }
}
