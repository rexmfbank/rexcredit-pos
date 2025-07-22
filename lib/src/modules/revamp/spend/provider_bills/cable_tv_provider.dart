// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:go_router/go_router.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:rex_app/src/modules/revamp/utils/data/rex_api/rex_api.dart';
// import 'package:rex_app/src/modules/revamp/dashboard_personal/providers/user_account_balance_provider.dart';
// import 'package:rex_app/src/modules/revamp/login/providers/login_provider.dart';
// import 'package:rex_app/src/modules/revamp/spend/provider_bill/cable_screen_state.dart';
// import 'package:rex_app/src/modules/revamp/spend/provider_bill/bill_payment_provider.dart';
// import 'package:rex_app/src/modules/shared/widgets/extension/snack_bar_ext.dart';
// import 'package:rex_app/src/modules/shared/widgets/modal_bottom_sheets/show_modal_action.dart';
// import 'package:rex_app/src/utils/extensions/extension_on_string.dart';
// import 'package:rex_app/src/utils/mixin/locator_mixin.dart';

// import '../../utils/config/routes/route_name.dart';
// import '../../../../utils/constants/string_assets.dart';
// import '../../../../utils/enums/enums.dart';
// import '../../../../utils/string_utils.dart';
// import '../../../shared/providers/app_preference_provider.dart';
// import '../../../shared/providers/meta_data_provider.dart';
// import '../../../shared/widgets/modal_bottom_sheets/show_confirm_pin_modal_sheet.dart';
// import '../bill_payment/shared/widgets/show_modal_choose_payment_method.dart';

// final cableTvProvider =
//     StateNotifierProvider.autoDispose<CableTvNotifier, CableScreenState>((ref) {
//       var authToken = ref.watch(appAuthTokenProvider) ?? '';
//       return CableTvNotifier(authToken, ref);
//     });

// class CableTvNotifier extends StateNotifier<CableScreenState> with LocatorMix {
//   CableTvNotifier(this.authToken, this.ref) : super(CableScreenState.initial());

//   final String authToken;
//   final StateNotifierProviderRef<CableTvNotifier, CableScreenState> ref;

//   void setSelectedServiceProvider(Biller biller) {
//     state = state.copyWith(
//       selectedServiceProvider: biller,
//       cableBillers: biller.products,
//     );
//   }

//   void filterCableBillers(String query) {
//     if (state.selectedServiceProvider != null &&
//         state.selectedServiceProvider?.products != null &&
//         state.selectedServiceProvider!.products!.isNotEmpty) {
//       if (query.isEmpty) {
//         state = state.copyWith(
//           cableBillers: state.selectedServiceProvider?.products,
//         );
//         return;
//       }

//       final filteredList =
//           state.selectedServiceProvider?.products!.where((services) {
//             final service = services.productName?.toLowerCase();
//             final input = query.toLowerCase();

//             return service?.contains(input) == true;
//           }).toList();

//       state = state.copyWith(cableBillers: filteredList);
//     }
//   }

//   void setSelectedBouquetPlan(
//     BuildContext context,
//     BillerProduct billerProduct,
//   ) {
//     state = state.copyWith(
//       selectedBouquetPlan: billerProduct,
//       bouquetPlanController: TextEditingController(
//         text: billerProduct.productName ?? '',
//       ),
//       amountController: TextEditingController(
//         text: billerProduct.amount.toString(),
//       ),
//     );
//     if (state.smartCardNumberController.text.isNotEmpty) {
//       // final debouncer = Debouncer(delay: 500);
//       // debouncer.run(() {
//       //   resetApiError();
//       //   validateSmartCardNo(context);
//       // });
//     }
//   }

//   void fillBeneficiaryInfo({
//     required String cardNumber,
//     required String billerCode,
//   }) {
//     state = state.copyWith(
//       smartCardNumberController: TextEditingController(text: cardNumber),
//       selectedServiceProvider: ref
//           .read(billPaymentProvider)
//           .cableBillers!
//           .firstWhere((element) => element.billerCode == billerCode),
//       cableBillers:
//           ref
//               .read(billPaymentProvider)
//               .cableBillers!
//               .firstWhere((element) => element.billerCode == billerCode)
//               .products,
//     );
//   }

//   void setIsBeneficiary(bool value) {
//     state = state.copyWith(isBeneficiary: value);
//   }

//   void clearFormError() => state = state.copyWith(formError: '');

//   void showPaymentMethodModal(BuildContext context) {
//     showModalChoosePaymentMethod(
//       context: context,
//       onNextTapped: () {
//         showConfirmPinModalSheet(
//           context: context,
//           title: StringAssets.confirmCableTv,
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

//   void showBouquetPlan(BuildContext context) {
//     if (state.selectedServiceProvider != null) {
//       //showSelectBouquetModal(context);
//     } else {
//       context.showToast(message: StringAssets.selectServiceProvider);
//     }
//   }

//   void validateCableTv(BuildContext context) {
//     final bouquetPlan = state.bouquetPlanController.text;
//     final amount = state.amountController.text;
//     final smartCardNo = state.smartCardNumberController.text;
//     final smartCardName = state.validateBillData?.customerName;

//     final availableBalance =
//         ref.read(userAcctBalanceProvider).value?.data?.availableBalance ?? 0.0;

//     if (state.selectedServiceProvider == null) {
//       state = state.copyWith(formError: StringAssets.selectServiceProvider);
//       return;
//     }

//     if (bouquetPlan.isBlank) {
//       state = state.copyWith(formError: StringAssets.selectBouquetPlan);
//       return;
//     }

//     if (amount.isBlank) {
//       state = state.copyWith(formError: StringAssets.invalidAmount);
//       return;
//     }

//     if (smartCardNo.isBlank || smartCardNo.length < 9) {
//       state = state.copyWith(formError: StringAssets.invalidSmartCardNo);
//       return;
//     }

//     if (smartCardName.isBlank) {
//       state = state.copyWith(formError: StringAssets.invalidSmartCardName);
//       return;
//     }
//     final doubleAmount = double.tryParse(amount) ?? 0.00;
//     if (doubleAmount >= availableBalance) {
//       showModalActionError(
//         context: context,
//         title: StringAssets.validationError,
//         errorText: StringAssets.insufficientAccountBalance,
//       );
//     }

//     context.push("${Routes.dashboardSpend}/${Routes.billCableTvConfirm}");
//   }

//   Future<void> validateSmartCardNo(BuildContext context) async {
//     state = state.copyWith(validateSmartCardNoLoading: true);
//     try {
//       final biller = state.selectedServiceProvider;
//       final product = state.selectedBouquetPlan;
//       final profileData = ref.watch(loginProvider).loginResponse.value?.data;

//       final validateBill = ValidateBillRequest(
//         entityCode: profileData?.entityCode,
//         billerCode: biller?.billerCode,
//         productCode: product?.productCode,
//         referenceNo: state.smartCardNumberController.text,
//         amount: state.amountController.text,
//         countryCode: biller?.countryCode,
//         serviceProvider: biller?.serviceProvider,
//       );

//       var apiResponse = await RexApi.instance.validateBill(
//         authToken: authToken,
//         request: validateBill,
//       );
//       state = state.copyWith(
//         validateSmartCardNoLoading: false,
//         validateBillData: apiResponse.data,
//       );
//     } catch (error, _) {
//       state = state.copyWith(
//         validateSmartCardNoLoading: false,
//         apiError: error.toString(),
//       );
//       if (context.mounted) {
//         context.showToast(message: error.toString());
//       }
//     }
//   }

//   Future<void> postBillPayment(
//     BuildContext context,
//     String transactionPin,
//   ) async {
//     state = state.copyWith(isLoading: true);

//     try {
//       final validateCableData = state.validateBillData;
//       final amount = state.amountController.text;
//       final biller = state.selectedServiceProvider;
//       final profileData = ref.watch(loginProvider).loginResponse.value?.data;
//       final deviceMetadata = ref.watch(deviceMetaProvider).asData?.value;
//       final Position? location = await getCurrentPosition(context);

//       var postBillPaymentRequest = PostBillPaymentRequest(
//         username: profileData?.username,
//         accountNo: profileData?.primaryAccountNo,
//         deviceId: deviceMetadata?.deviceNumber,
//         productCode: state.selectedBouquetPlan?.productCode,
//         ccy: profileData?.ccy ?? 'NGN',
//         amount: num.tryParse(amount),
//         charge: 0,
//         narration: "cable tv",
//         merchantId: "",
//         tranCode: TransactionCodes.cable.jsonString,
//         tranType: BillerCategories.cable.jsonString,
//         userId: "",
//         mobileNo: null,
//         paymentMethod: "CASH",
//         serviceProvider: biller?.serviceProvider,
//         billerCode: biller?.billerCode,
//         terminalId: profileData?.terminalId,
//         entityCode: profileData?.entityCode,
//         cardData: null,
//         customerName: validateCableData?.customerName,
//         billRefNo: state.smartCardNumberController.text,
//         geolocation:
//             location != null
//                 ? "${location.latitude},${location.longitude}"
//                 : "0,0",
//         externalRefNo: generateExternalRefNo(),
//         saveBeneficiary: state.isBeneficiary,
//         channelType: "MOBILE",
//       );

//       var apiResponse = await RexApi.instance.postBillPayment(
//         authToken: authToken,
//         appVersion: ref.read(appVersionProvider),
//         request: postBillPaymentRequest,
//         transactionPin: transactionPin,
//       );
//       state = state.copyWith(
//         isLoading: false,
//         postBillPaymentSuccess: apiResponse.data,
//       );
//     } catch (error, _) {
//       state = state.copyWith(isLoading: false, apiError: error.toString());
//     }
//   }

//   ///This function allows me to reset the error field after it has been shown to
//   ///the User so it does not pop up automatically when user retries
//   void resetApiError() {
//     state = state.copyWith(apiError: '');
//   }
// }
