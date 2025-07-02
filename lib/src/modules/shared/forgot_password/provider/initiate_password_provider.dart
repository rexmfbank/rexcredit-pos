// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/utils/data/rex_api/rex_api.dart';
import 'package:rex_app/src/modules/revamp/utils/config/routes/route_name.dart';
import 'package:rex_app/src/modules/shared/forgot_password/model/initiate_password_state.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/loading_screen.dart';
import 'package:rex_app/src/modules/shared/widgets/modal_bottom_sheets/show_modal_action.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';
import 'package:rex_app/src/utils/extensions/extension_on_string.dart';

final initiatePasswordProvider = AutoDisposeNotifierProvider<
    InitiatePasswordNotifier, InitiatePasswordState>(
  () => InitiatePasswordNotifier(),
);

class InitiatePasswordNotifier
    extends AutoDisposeNotifier<InitiatePasswordState> {
  @override
  InitiatePasswordState build() {
    return InitiatePasswordState(
      nameController: TextEditingController(),
    );
  }

  Future<void> initiatePasswordReset(BuildContext context) async {
    if (state.nameController.text.isBlank) {
      showModalActionError(
        context: context,
        errorText: StringAssets.emptyUsername,
        title: StringAssets.emptyValueText,
      );
      return;
    }

    LoadingScreen.instance().show(context: context);
    try {
      await RexApi.instance.initiatePasswordReset(
        appVersion: ref.read(appVersionProvider),
        username: state.nameController.text,
        entityCode: 'RMB',
      );
      LoadingScreen.instance().hide();
      context.push(Routes.resetPassword);
    } catch (error) {
      LoadingScreen.instance().hide();
      showModalActionError(context: context, errorText: error.toString());
    }
  }
}
