import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_api/rex_api.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';

final fetchMaritalStatusList =
    FutureProvider.autoDispose<List<FetchLookupDataByCodeResponseData>?>(
        (ref) async {
  final authToken = ref.watch(userAuthTokenProvider);
  final api = await RexApi.instance.fetchlookupDataByCode(
    authToken: authToken ?? '',
    lookupCode: 'MARITAL_STATUS',
    entityCode: ref.watch(userEntityCodeProvider),
  );
  return api.list;
});

final fetchEmploymentStatusList =
    FutureProvider.autoDispose<List<FetchLookupDataByCodeResponseData>?>(
        (ref) async {
  final authToken = ref.watch(userAuthTokenProvider);
  final api = await RexApi.instance.fetchlookupDataByCode(
    authToken: authToken ?? '',
    lookupCode: 'EMPLOYED_STATUS',
    entityCode: ref.watch(userEntityCodeProvider),
  );
  return api.list;
});

final fetchEducationalStatusList =
    FutureProvider.autoDispose<List<FetchLookupDataByCodeResponseData>?>(
        (ref) async {
  final authToken = ref.watch(userAuthTokenProvider);
  final api = await RexApi.instance.fetchlookupDataByCode(
    authToken: authToken ?? '',
    lookupCode: 'EDUCATIONAL_STATUS',
    entityCode: ref.watch(userEntityCodeProvider),
  );
  return api.list;
});

final fetchCompanySectorList =
    FutureProvider.autoDispose<List<FetchLookupDataByCodeResponseData>?>(
        (ref) async {
  final authToken = ref.watch(userAuthTokenProvider);
  final api = await RexApi.instance.fetchlookupDataByCode(
    authToken: authToken ?? '',
    lookupCode: 'COMPANY_SECTOR',
    entityCode: ref.watch(userEntityCodeProvider),
  );
  return api.list;
});

final fetchGuarantorRelationshipList =
    FutureProvider.autoDispose<List<FetchLookupDataByCodeResponseData>?>(
        (ref) async {
  final authToken = ref.watch(userAuthTokenProvider);
  final api = await RexApi.instance.fetchlookupDataByCode(
    authToken: authToken ?? '',
    lookupCode: 'RELATIONSHIP',
    entityCode: ref.watch(userEntityCodeProvider),
  );
  return api.list;
});

final fetchLoanPurposeList =
    FutureProvider.autoDispose<List<FetchLookupDataByCodeResponseData>?>(
        (ref) async {
  final authToken = ref.watch(userAuthTokenProvider);
  final api = await RexApi.instance.fetchlookupDataByCode(
    authToken: authToken ?? '',
    lookupCode: 'LOAN_PURPOSE',
    entityCode: ref.watch(userEntityCodeProvider),
  );
  return api.list;
});
