import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/data/rex_api/rex_api.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/modal_bottom_sheets/show_modal_action.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

final updatePersonalInfoProvider =
    AsyncNotifierProvider<UpdatePersonalInfoNotifier, UpdateUserResponse>(
      () => UpdatePersonalInfoNotifier(),
    );

class UpdatePersonalInfoNotifier extends AsyncNotifier<UpdateUserResponse> {
  @override
  FutureOr<UpdateUserResponse> build() {
    return const UpdateUserResponse.empty();
  }

  Future<void> updateUserPersonalInfo({
    required UpdateUserRequest request,
    required BuildContext context,
  }) async {
    state = const AsyncValue.loading();
    final authToken = ref.watch(appAuthTokenProvider) ?? 'null';
    try {
      final res = await RexApi.instance.updateUser(
        authToken: authToken,
        request: request,
      );
      state = AsyncValue.data(res);
      if (context.mounted) {
        showModalAction(
          context: context,
          dialogTitle: StringAssets.personalInfoSaved,
          dialogSubtitle: StringAssets.personalInfoSavedSubtext,
          onPressed: () {
            context.pop();
            context.pop();
          },
        );
      }
    } catch (error, stack) {
      state = AsyncValue.error(error, stack);
      if (context.mounted) {
        // do something
      }
    }
  }
}
