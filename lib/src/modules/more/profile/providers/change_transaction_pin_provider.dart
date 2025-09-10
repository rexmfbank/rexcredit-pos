import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/data/rex_api/rex_api.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';

final resetPinApiProvider =
    AsyncNotifierProvider<ResetPinNotifier, ChangePinResponse>(
      () => ResetPinNotifier(),
    );

class ResetPinNotifier extends AsyncNotifier<ChangePinResponse> {
  void resetPin({
    required String token,
    required ChangePinRequest request,
  }) async {
    state = const AsyncValue.loading();
    try {
      final res = await RexApi.instance.changeTransactionPin(
        authToken: token,
        appVersion: ref.read(appVersionProvider),
        request: request,
      );
      state = AsyncValue.data(res);
    } catch (error, stack) {
      state = AsyncValue.error(error, stack);
    }
  }

  @override
  FutureOr<ChangePinResponse> build() {
    return ChangePinResponse.empty();
  }
}

final oldPinProvider = NotifierProvider<SetPinNotifier, String>(
  () => SetPinNotifier(),
);

final newPinProvider = NotifierProvider<NewPinNotifier, String>(
  () => NewPinNotifier(),
);

final confirmPinProvider = NotifierProvider<ConfirmPinNotifier, String>(
  () => ConfirmPinNotifier(),
);

class SetPinNotifier extends Notifier<String> {
  void onChanged(String value) => state = value;

  @override
  String build() => '';
}

class NewPinNotifier extends Notifier<String> {
  void onChanged(String value) => state = value;

  @override
  String build() => '';
}

class ConfirmPinNotifier extends Notifier<String> {
  void onChanged(String value) => state = value;

  @override
  String build() => '';
}
