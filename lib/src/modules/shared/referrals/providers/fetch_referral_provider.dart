import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/utils/data/rex_api/rex_api.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';

final fetchReferralProvider =
    FutureProvider.autoDispose<UserReferralData?>((ref) async {
  final authToken = ref.watch(appAuthTokenProvider);
  final res = await RexApi.instance.fetchReferrals(
    authToken: authToken ?? '',
    referralCode: '',
  );
  return res.data;
});
