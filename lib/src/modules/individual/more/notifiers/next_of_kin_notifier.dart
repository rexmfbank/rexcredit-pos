import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/utils/data/rex_api/rex_api.dart';

class NextOfKinRelationshipNotifier
    extends Notifier<FetchLookupDataByCodeResponseData> {
  @override
  FetchLookupDataByCodeResponseData build() {
    return FetchLookupDataByCodeResponseData.empty();
  }

  void onDropdownChange(FetchLookupDataByCodeResponseData? value) {
    state = value!;
  }
}
