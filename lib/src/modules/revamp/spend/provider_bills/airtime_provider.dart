// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:go_router/go_router.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:rex_app/src/modules/revamp/utils/data/rex_api/rex_api.dart';
// import 'package:rex_app/src/modules/revamp/utils/config/routes/route_name.dart';
// import 'package:rex_app/src/modules/revamp/dashboard_personal/providers/user_account_balance_provider.dart';
// import 'package:rex_app/src/modules/revamp/login/providers/login_provider.dart';
// import 'package:rex_app/src/modules/revamp/spend/provider_bill/airtime_screen_state.dart';
// import 'package:rex_app/src/modules/revamp/spend/provider_bill/bill_payment_provider.dart';
// import 'package:rex_app/src/modules/shared/widgets/modal_bottom_sheets/show_modal_action.dart';
// import 'package:rex_app/src/utils/constants/string_assets.dart';
// import 'package:rex_app/src/utils/enums/enums.dart';
// import 'package:rex_app/src/utils/extensions/extension_on_string.dart';
// import 'package:rex_app/src/utils/mixin/locator_mixin.dart';
// import 'package:rex_app/src/utils/string_utils.dart';

// import '../../../../utils/date_utils/change_date_format.dart';
// import '../../../shared/providers/app_preference_provider.dart';
// import '../../../shared/providers/meta_data_provider.dart';
// import '../../../shared/widgets/modal_bottom_sheets/show_confirm_pin_modal_sheet.dart';
// import '../bill_payment/shared/widgets/show_modal_choose_payment_method.dart';

// final airtimeProvider =
//     StateNotifierProvider.autoDispose<AirtimeNotifier, AirtimeScreenState>(
//         (ref) {
//   var authToken = ref.watch(appAuthTokenProvider) ?? '';
//   return AirtimeNotifier(authToken, ref);
// });

// class AirtimeNotifier extends StateNotifier<AirtimeScreenState>
//     with LocatorMix {
//   AirtimeNotifier(this.authToken, this.ref)
//       : super(AirtimeScreenState.initial());

//   final String authToken;
//   final StateNotifierProviderRef<AirtimeNotifier, AirtimeScreenState> ref;

//   void setSelectedServiceProvider(Biller biller) {
//     state = state.copyWith(selectedServiceProvider: biller);
//   }

//   void setIsBeneficiary(bool value) {
//     state = state.copyWith(isBeneficiary: value);
//   }

//   void clearFormError() => state = state.copyWith(formError: '');

//   void validateAirtime(BuildContext context) {
//     final phoneNumber = state.phoneNumberController.text;
//     final amount = state.amountController.text;
//     final availableBalance =
//         ref.read(userAcctBalanceProvider).value?.data?.availableBalance ?? 0.0;

//     if (phoneNumber.isBlank || phoneNumber.length < 11) {
//       state = state.copyWith(formError: StringAssets.invalidPhoneNo);
//       return;
//     }

//     if (state.selectedServiceProvider == null) {
//       state = state.copyWith(formError: StringAssets.selectServiceProvider);
//       return;
//     }

//     if (amount.isBlank) {
//       state = state.copyWith(formError: StringAssets.invalidAmount);
//       return;
//     }

//     final doubleAmount = double.tryParse(amount) ?? 0.00;
//     if (doubleAmount < 50.00) {
//       state = state.copyWith(
//           formError: StringAssets.transactionAmountShouldNotBeLess('50'));
//       return;
//     }

//     if (doubleAmount >= availableBalance) {
//       showModalActionError(
//           context: context,
//           title: StringAssets.validationError,
//           errorText: StringAssets.insufficientAccountBalance);
//       return;
//     }

//     context.push('${Routes.dashboardSpend}/${Routes.billAirtimeConfirm}');
//   }

//   void showPaymentMethodModal(BuildContext context) {
//     showModalChoosePaymentMethod(
//       context: context,
//       onNextTapped: () {
//         showConfirmPinModalSheet(
//           context: context,
//           title: StringAssets.confirmAirtime,
//           onPinEntered: (value) {
//             context.pop();

//             if (value.length == 4) {
//               postBillPayment(context, value);
//             }
//           },
//         );
//       },
//     );
//   }

//   Future<void> postBillPayment(
//     BuildContext context,
//     String transactionPin,
//   ) async {
//     state = state.copyWith(isLoading: true);

//     try {
//       final amount = state.amountController.text;
//       final biller = state.selectedServiceProvider;

//       final profileData = ref.watch(loginProvider).loginResponse.value?.data;
//       final deviceMetadata = ref.watch(deviceMetaProvider).asData?.value;
//       final Position? location = await getCurrentPosition(context);

//       var postBillPaymentRequest = PostBillPaymentRequest(
//         username: profileData?.username,
//         accountNo: profileData?.primaryAccountNo,
//         deviceId: deviceMetadata?.deviceNumber,
//         productCode: null,
//         ccy: profileData?.ccy ?? 'NGN',
//         amount: num.tryParse(amount),
//         charge: 0,
//         narration: "airtime",
//         merchantId: "",
//         tranCode: TransactionCodes.topUp.jsonString,
//         tranType: "Airtime Top-Up",
//         userId: "",
//         mobileNo: state.phoneNumberController.text,
//         paymentMethod: "CASH",
//         serviceProvider: biller?.serviceProvider,
//         billerCode: biller?.billerCode,
//         terminalId: profileData?.terminalId,
//         entityCode: profileData?.entityCode,
//         cardData: null,
//         customerName: profileData?.username,
//         billRefNo: biller?.billerRef,
//         geolocation: location != null
//             ? "${location.latitude},${location.longitude}"
//             : "0,0",
//         externalRefNo: generateExternalRefNo(),
//         saveBeneficiary: state.isBeneficiary,
//         channelType: "MOBILE",
//       );

//       var apiResponse = await RexApi.instance.postBillPayment(
//         authToken: authToken,
//         appVersion: ref.read(appVersionProvider),
//         transactionPin: transactionPin,
//         request: postBillPaymentRequest,
//       );
//       state = state.copyWith(
//           isLoading: false, postBillPaymentSuccess: apiResponse.data);
//     } catch (error, _) {
//       state = state.copyWith(isLoading: false, apiError: error.toString());
//     }
//   }

//   ///This function allows me to reset the error field after it has been shown to
//   ///the User so it does not pop up automatically when user retries
//   void updateApiError() {
//     state = state.copyWith(apiError: '');
//   }

//   Future<void> fetchMiniStatement(
//     BuildContext context, {
//     required int pageKey,
//   }) async {
//     try {
//       const int pageSize = 10;
//       final profileData = ref.watch(loginProvider).loginResponse.value?.data;
//       final miniStatementRequest = MiniStatementRequest(
//         accountNo: profileData?.primaryAccountNo,
//         startDate: state.startDate,
//         endDate: state.endDate,
//         entityCode: profileData?.entityCode,
//         tranCode: TransactionCodes.topUp.jsonString,
//         pageIndex: pageKey,
//         pageSize: pageSize,
//       );

//       var apiResponse = await RexApi.instance.fetchMiniStatement(
//         authToken: authToken,
//         request: miniStatementRequest,
//       );

//       final newItems = apiResponse.data ?? [];
//       final isLastPage = newItems.length < pageSize;
//       if (isLastPage) {
//         state.historyPagingController.appendLastPage(newItems);
//       } else {
//         final nextPageKey = pageKey + 1;
//         state.historyPagingController.appendPage(newItems, nextPageKey);
//       }
//     } catch (error, _) {
//       state.historyPagingController.error = error;
//     }
//   }

//   void initPagingController(BuildContext context) {
//     state.historyPagingController.addPageRequestListener((pageKey) {
//       fetchMiniStatement(
//         context,
//         pageKey: pageKey,
//       );
//     });
//   }

//   void fillBeneficiaryInfo({
//     required String phone,
//     required String billerCode,
//   }) {
//     state = state.copyWith(
//       phoneNumberController: TextEditingController(text: phone),
//       selectedServiceProvider: ref
//           .read(billPaymentProvider)
//           .airtimeBillers
//           ?.billers!
//           .firstWhere((element) => element.billerCode == billerCode),
//     );
//   }

//   void onDatePicked(DateTimeRange dateTimeRange) {
//     var startDate = convertDateTimeToyyyymmddFormat(dateTimeRange.start) ?? '';
//     var endDate = convertDateTimeToyyyymmddFormat(dateTimeRange.end) ?? '';
//     state = state.copyWith(startDate: startDate, endDate: endDate);

//     state.historyPagingController.refresh();
//   }
// }
