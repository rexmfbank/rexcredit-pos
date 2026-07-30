import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/login/forgot_password/provider/forgot_password_provider.dart';
import 'package:rex_app/src/modules/utils/general/constants.dart';
import 'package:rex_app/src/modules/utils/theme/app_colors.dart';
import 'package:rex_app/src/modules/utils/widgets/app_scaffold.dart';
import 'package:rex_app/src/modules/utils/widgets/appbar_sub_screen.dart';
import 'package:rex_app/src/modules/utils/widgets/rex_elevated_button.dart';
import 'package:rex_app/src/modules/utils/widgets/rex_text_field.dart';

class ForgotPasscodeEmailScreen extends ConsumerWidget {
  const ForgotPasscodeEmailScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(forgotPasswordProvider);

    return AppScaffold(
      isLoading: state.isLoading,
      backgroundColor: AppColors.rexBackground,
      padding: EdgeInsets.all(0),
      resizeToAvoidBottomInset: true,
      appBar: AppbarLoginScreen(
        onBackBtnPress: () => context.pop(),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          SizedBox(height: 16.ah),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.aw),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Forgot Passcode',
                  style: TextStyle(
                    fontSize: 28.asp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.rexPurpleDark,
                  ),
                ),
                SizedBox(height: 6.ah),
                Text(
                  'Enter your email to receive a reset code',
                  style: TextStyle(
                    fontSize: 14.asp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.rexTint500,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 24.ah),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.aw),
            child: RexTextField(
              controller: state.email,
              outerTitle: 'Email Address',
              showOuterTile: true,
              hintText: 'Enter Email Address',
              inputType: TextInputType.emailAddress,
              textInputAction: TextInputAction.done,
              horizontalPadding: 0,
              enableSuggestions: false,
              autocorrect: false,
            ),
          ),
          SizedBox(height: 24.ah),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.aw),
            child: RexElevatedButton(
              onPressed: () {
                ref.read(forgotPasswordProvider.notifier).sendOtp(context);
              },
              buttonTitle: 'Continue',
            ),
          ),
          SizedBox(height: 24.ah),
        ],
      ),
    );
  }
}
