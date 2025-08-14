import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/utils/data/rex_api/rex_api.dart';
import 'package:rex_app/src/modules/more/notifiers/next_of_kin_notifier.dart';

final nextOfKinRelationshipProvider = NotifierProvider<
  NextOfKinRelationshipNotifier,
  FetchLookupDataByCodeResponseData
>(() => NextOfKinRelationshipNotifier());

// final securityQuestionProvider = NotifierProvider<SecurityQuestionNotifier,
//     FetchLookupDataByCodeResponseData>(
//   () => SecurityQuestionNotifier(),
// );

final profilePageViewIndexProvider = StateProvider.autoDispose<int>((ref) {
  return 0;
});
