import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/data/rex_api/rex_api.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';
import 'package:rex_app/src/utils/enums/account_type.dart';

final kycDocumentFutureProvider = FutureProvider<List<KycDocInfo>>((ref) async {
  final authToken = ref.watch(userAuthTokenProvider) ?? 'null';
  final kycDocs = await RexApi.instance.getKycDocs(
    authToken: authToken,
    query: GetKycDocsQuery(
      username: ref.watch(usernameProvider) ?? '',
      entityCode: 'RMB',
      category: ref.watch(userIsIndividualProvider)
          ? AccountType.individual.requestString
          : AccountType.business.requestString,
    ),
  );
  return kycDocs.data ?? [];
});

final selectedKycDocumentProvider = StateProvider<KycDocInfo?>((ref) => null);
