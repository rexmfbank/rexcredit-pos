import 'package:rex_app/src/modules/revamp/data/rex_api/rex_api.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';

final fetchDisputesProvider =
    FutureProvider.autoDispose<List<FetchDisputeData>?>((ref) async {
  final authToken = ref.watch(appAuthTokenProvider);
  final res = await RexApi.instance.fetchDisputes(authToken: authToken ?? '');
  return res.data;
});
