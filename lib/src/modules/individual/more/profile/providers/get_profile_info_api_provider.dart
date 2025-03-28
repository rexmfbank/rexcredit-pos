import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_api/rex_api.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';

final getProfileInfoProvider =
    AsyncNotifierProvider<GetProfileInfoProvider, GetProfileResponseData>(
  () => GetProfileInfoProvider(),
);

class GetProfileInfoProvider extends AsyncNotifier<GetProfileResponseData> {
  @override
  FutureOr<GetProfileResponseData> build() {
    return GetProfileResponseData.empty();
  }

  Future<void> getProfileInfo() async {
    state = const AsyncValue.loading();
    final authToken = ref.watch(userAuthTokenProvider) ?? 'null';
    try {
      final res = await RexApi.instance.getProfileInfo(token: authToken);
      state = AsyncValue.data(res.data!);
      _saveDetails(res.data!);
    } catch (error, stack) {
      state = AsyncValue.error(error, stack);
    }
  }

  void _saveDetails(GetProfileResponseData profileResponseData) {
    ref.read(userBVNProvider.notifier).state = profileResponseData.bvn;
    ref.read(userNINProvider.notifier).state = profileResponseData.bvn;
  }
}

final fetchProfileInformationProvider =
    FutureProvider.autoDispose<GetProfileResponseData?>((ref) async {
  final authToken = ref.watch(userAuthTokenProvider);
  try {
    final api = await RexApi.instance.getProfileInfo(token: authToken ?? '');
    return api.data;
  } catch (error) {
    GetProfileResponseData.empty();
    // throw error.toString();
  }
});
