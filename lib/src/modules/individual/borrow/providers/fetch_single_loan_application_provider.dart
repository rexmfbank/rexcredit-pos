import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/data/rex_api/rex_api.dart';
import 'package:rex_app/src/modules/individual/borrow/providers/loan_application_provider.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';

final fetchSingleLoanApplicationProvider =
    FutureProvider<LoanApplicationResponseData>((ref) async {
  final authToken = ref.watch(userAuthTokenProvider) ?? 'null';
  final loanRefCode = ref.watch(selectedLoanRefCodeProvider.notifier).state;
  if (loanRefCode.isEmpty) {
    return LoanApplicationResponseData.empty();
  }
  final loanApplicationResponse =
      await RexApi.instance.fetchSingleLoanApplication(
    authToken: authToken,
    loanRefCode: loanRefCode,
  );
  return loanApplicationResponse.data ?? LoanApplicationResponseData.empty();
});
