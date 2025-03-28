import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_api/rex_api.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';

final stateListProvider = FutureProvider<List<StateData>>((ref) async {
  final authToken = ref.watch(userAuthTokenProvider) ?? 'null';
  final stateList = await RexApi.instance.getState(authToken: authToken);
  return stateList;
});
