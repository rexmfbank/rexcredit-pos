import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_api/rex_api.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/shared/login/providers/login_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/page_widgets/app_scaffold.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_elevated_button.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

import '../../../../../shared/models/text_field_validator.dart';
import '../../../../../shared/providers/meta_data_provider.dart';
import '../../../../../shared/widgets/loading_screen.dart';
import '../../../../../shared/widgets/modal_bottom_sheets/show_modal_action.dart';
import '../../../../../shared/widgets/rex_text_field_password.dart';
import '../../providers/change_password_api_provider.dart';

class ChangePasswordScreen extends ConsumerStatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends ConsumerState<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final currentPassController = TextEditingController();
  final newPassController = TextEditingController();
  final confirmPassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final meta = ref.watch(deviceMetaProvider).asData?.value;
    ref.listen(
      changePasswordApiProvider,
      (_, state) {
        state.when(
          data: (data) {
            LoadingScreen.instance().hide();
            showModalActionSuccess(
              context: context,
              title: StringAssets.passwordChangedSuccessfully,
              subtitle: StringAssets.passwordChangedDesc,
              onPressed: () {
                context.pop();
                context.pop();
              },
            );
          },
          error: (error, stackTrace) {
            LoadingScreen.instance().hide();
            showModalActionError(context: context, errorText: error.toString());
          },
          loading: () {
            LoadingScreen.instance().show(context: context);
          },
        );
      },
    );
    //
    return AppScaffold(
      backgroundColor: AppColors.rexBackgroundGrey,
      appBar: RexAppBar(
        step: '',
        shouldHaveBackButton: true,
        title: StringAssets.changePasswordTitle,
        subtitle: StringAssets.changePasswordSubtitle,
        onBackButtonPressed: () => context.pop(),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            SizedBox(height: 20.ah),
            RexTextFieldPassword(
              outerTitle: StringAssets.changePasswordText1,
              hintText: StringAssets.passwordCurrentHint,
              controller: currentPassController,
              validator: (value) => TextfieldValidator.input(value),
              verticalPadding: 0,
              horizontalPadding: 0,
            ),
            SizedBox(height: 20.ah),
            RexTextFieldPassword(
              outerTitle: StringAssets.changePasswordText2,
              hintText: StringAssets.passwordNewHint,
              controller: newPassController,
              validator: (value) => TextfieldValidator.password(value),
              verticalPadding: 0,
              horizontalPadding: 0,
            ),
            SizedBox(height: 20.ah),
            RexTextFieldPassword(
              outerTitle: StringAssets.changePasswordText3,
              hintText: StringAssets.passwordNewConfirmHint,
              controller: confirmPassController,
              validator: (value) => TextfieldValidator.confirmPassword(
                value: value,
                password: newPassController.text,
              ),
              verticalPadding: 0,
              horizontalPadding: 0,
            ),
            SizedBox(height: 32.ah),
            RexElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  debugPrint("onClick Change password!!");
                  ChangePinRequest form = ChangePinRequest(
                      oldPin: currentPassController.text,
                      newPin: newPassController.text,
                      entityCode: ref
                              .read(loginProvider)
                              .loginResponse
                              .value
                              ?.data
                              .entityCode ??
                          'RMB',
                      deviceId: meta?.deviceNumber ?? 'deviceId');
                  ref
                      .read(changePasswordApiProvider.notifier)
                      .changePassword(request: form);
                }
              },
              buttonTitle: StringAssets.updateTextOnButton,
              backgroundColor: null,
            ),
          ],
        ),
      ),
    );
  }
}
