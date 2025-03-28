import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_api/rex_api.dart';

final fetchRegisterEmploymentStatusList =
    FutureProvider.autoDispose<List<FetchLookupDataByCodeResponseData>?>(
        (ref) async {
  final api = await RexApi.instance.fetchRegisterlookupDataByCode(
    lookupCode: 'EMPLOYMENT_CATEGORY',
    entityCode: '',
  );
  return api.list;
});

final fetchRegisterIncomeRangeList =
    FutureProvider.autoDispose<List<FetchLookupDataByCodeResponseData>?>(
        (ref) async {
  final api = await RexApi.instance.fetchRegisterlookupDataByCode(
    lookupCode: 'ANNUAL_INCOME_RANGE',
    entityCode: '',
  );
  return api.list;
});
