import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:rex_app/src/modules/revamp/utils/data/rex_api/rex_api.dart';
import 'package:rex_app/src/modules/revamp/utils/config/app_config.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';

final changePasswordApiProvider =
    AsyncNotifierProvider<ChangePasswordApiNotifier, ChangePinResponse>(
  () => ChangePasswordApiNotifier(),
);

class ChangePasswordApiNotifier extends AsyncNotifier<ChangePinResponse> {
  @override
  FutureOr<ChangePinResponse> build() {
    return ChangePinResponse.empty();
  }

  Future<void> changePassword({
    required ChangePinRequest request,
  }) async {
    state = const AsyncValue.loading();
    final authToken = ref.watch(appAuthTokenProvider) ?? 'null';
    try {
      final res = await RexApi.instance.changePassword(
        token: authToken,
        appVersion: ref.read(appVersionProvider),
        request: request,
      );
      state = AsyncValue.data(res);
    } catch (error, stack) {
      debugPrint("Change Password Error: $error");
      debugPrint(stack.toString());
      state = AsyncValue.error(error, stack);
    }
  }
}
