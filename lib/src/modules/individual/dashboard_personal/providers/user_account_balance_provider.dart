import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/data/rex_api/rex_api.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';

// final userAcctBalanceProvider = AutoDisposeAsyncNotifierProvider<
//     UserAccountBalance, InternalBalanceEnquiryResponse>(
//   () => UserAccountBalance(),
// );

final userAcctBalanceProvider =
    FutureProvider.autoDispose<InternalBalanceEnquiryResponse>((ref) async {
  final authToken = ref.watch(userAuthTokenProvider);
  final userAcctNumber = ref.watch(userNubanProvider);
  //
  final res = await RexApi.instance.makeInternalBalanceEnquiry(
    token: authToken ?? '',
    request: InternalBalanceEnquiryRequest(
      bankCode: ref.watch(userEntityCodeProvider),
      accountNumber: userAcctNumber,
    ),
  );
  return res;
});

// class UserAccountBalance
//     extends AutoDisposeAsyncNotifier<InternalBalanceEnquiryResponse> {
//   @override
//   FutureOr<InternalBalanceEnquiryResponse> build() {
//     return InternalBalanceEnquiryResponse.empty();
//   }

//   Future<void> getAccountBalance() async {
//     final userToken = ref.watch(userAuthTokenProvider);
//     final userAcctNumber = ref.watch(userNubanProvider);
//     //
//     state = const AsyncValue.loading();
//     try {
//       final res = await RexApi.instance.makeInternalBalanceEnquiry(
//         token: userToken ?? '',
//         request: InternalBalanceEnquiryRequest(
//           bankCode: 'RMB',
//           accountNumber: userAcctNumber,
//         ),
//       );
//       state = AsyncValue.data(res);
//     } catch (error, stackTrace) {
//       state = AsyncValue.error(error, stackTrace);
//     }
//   }
// }
