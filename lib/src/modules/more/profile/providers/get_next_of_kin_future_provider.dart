import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/data/rex_api/rex_api.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';

final getNextOfKinFutureProvider =
    FutureProvider<GetNextOfKinData>((ref) async {
  final authToken = ref.watch(appAuthTokenProvider) ?? 'null';
  final nextOfKin = await RexApi.instance.getNextOfKin(token: authToken);
  return nextOfKin.data ?? GetNextOfKinData.empty();
});
