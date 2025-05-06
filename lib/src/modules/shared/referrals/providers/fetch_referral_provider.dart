import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/data/rex_api/rex_api.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';

final fetchReferralProvider =
    FutureProvider.autoDispose<UserReferralData?>((ref) async {
  final authToken = ref.watch(userAuthTokenProvider);
  final refCode = ref.watch(userReferralCodeProvider);
  final res = await RexApi.instance.fetchReferrals(
    authToken: authToken ?? '',
    referralCode: refCode,
  );
  return res.data;
});
