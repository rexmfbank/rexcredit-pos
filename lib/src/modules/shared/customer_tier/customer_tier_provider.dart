import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_api/rex_api.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';

final customerTierProvider = FutureProvider<CustomerTierResponse>((ref) async {
  final authToken = ref.watch(userAuthTokenProvider) ?? '';
  final res = await RexApi.instance.getCustomerAccountLimit(token: authToken);
  return res;
});
