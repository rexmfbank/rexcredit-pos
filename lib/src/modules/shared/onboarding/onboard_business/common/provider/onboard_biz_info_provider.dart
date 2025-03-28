import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_api/rex_api.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';

final onboardBizInfoProvider =
    FutureProvider<OnboardBusinessInfoResponse>((ref) async {
  final username = ref.watch(usernameProvider);
  final res = await RexApi.instance.onboardBusinessInfo(username: username);
  return res;
});
