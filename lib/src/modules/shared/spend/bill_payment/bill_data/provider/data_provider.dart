import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/data/rex_api/rex_api.dart';
import 'package:rex_app/src/modules/shared/spend/bill_payment/bill_data/states/data_screen_state.dart';
import 'package:rex_app/src/modules/shared/spend/bill_payment/bill_data/widgets/select_data_plan_modal_sheet.dart';
import 'package:rex_app/src/modules/shared/spend/bill_payment/shared/providers/bill_payment_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/extension/snack_bar_ext.dart';
import 'package:rex_app/src/utils/extensions/extension_on_string.dart';
import 'package:rex_app/src/utils/mixin/locator_mixin.dart';

import '../../../../../../config/routes/route_name.dart';
import '../../../../../../utils/constants/string_assets.dart';
import '../../../../../../utils/enums/enums.dart';
import '../../../../../../utils/string_utils.dart';
import '../../../../../shared/login/providers/login_provider.dart';
import '../../../../../shared/providers/app_preference_provider.dart';
import '../../../../../shared/providers/meta_data_provider.dart';
import '../../../../../shared/widgets/modal_bottom_sheets/show_confirm_pin_modal_sheet.dart';
import '../../shared/widgets/show_modal_choose_payment_method.dart';

final billPaymentDataProvider =
    StateNotifierProvider.autoDispose<BillPaymentDataNotifier, DataScreenState>(
        (ref) {
  var authToken = ref.watch(userAuthTokenProvider) ?? '';
  return BillPaymentDataNotifier(authToken, ref);
});

class BillPaymentDataNotifier extends StateNotifier<DataScreenState>
    with LocatorMix {
  BillPaymentDataNotifier(this.authToken, this.ref)
      : super(DataScreenState.initial());

  final String authToken;
  final StateNotifierProviderRef<BillPaymentDataNotifier, DataScreenState> ref;

  void setSelectedServiceProvider(Biller biller) {
    state = state.copyWith(
      selectedServiceProvider: biller,
      products: biller.products,
    );
  }

  void setSelectedDataPlan(BillerProduct billerProduct) {
    state = state.copyWith(
        selectedDataPlan: billerProduct,
        dataPlanController:
            TextEditingController(text: billerProduct.productName ?? ''),
        amountController: TextEditingController(
          text: billerProduct.amount.toString(),
        ));
  }

  void setIsBeneficiary(bool value) {
    state = state.copyWith(isBeneficiary: value);
  }

  void clearFormError() => state = state.copyWith(formError: '');

  void validateData(BuildContext context) {
    final phoneNumber = state.phoneNumberController.text;
    final amount = state.amountController.text;

    if (phoneNumber.isBlank || phoneNumber.length < 11) {
      state = state.copyWith(formError: StringAssets.invalidPhoneNo);
      return;
    }

    if (state.selectedServiceProvider == null) {
      state = state.copyWith(formError: StringAssets.selectServiceProvider);
      return;
    }

    if (state.selectedDataPlan == null) {
      state = state.copyWith(formError: StringAssets.selectDataPlan);
      return;
    }

    if (amount.isBlank) {
      state = state.copyWith(formError: StringAssets.invalidAmount);
      return;
    }

    final numAmount = num.tryParse(amount) ?? 0;
    if (numAmount <= 0) {
      state = state.copyWith(
          formError: StringAssets.transactionAmountShouldNotBeLess('20'));
      return;
    }

    context.push('${Routes.dashboardSpend}/${Routes.billDataConfirm}');
  }

  void showPaymentMethodModal(BuildContext context) {
    showModalChoosePaymentMethod(
      context: context,
      onNextTapped: () {
        showConfirmPinModalSheet(
          context: context,
          title: StringAssets.confirmAirtime,
          onPinEntered: (value) {
            context.pop();

            if (value.length == 4) {
              postBillPayment(context, value);
            }
          },
        );
      },
    );
  }

  void filterData(String query) {
    if (state.selectedServiceProvider != null &&
        state.selectedServiceProvider?.products != null &&
        state.selectedServiceProvider!.products!.isNotEmpty) {
      if (query.isEmpty) {
        state = state.copyWith(
          products: state.selectedServiceProvider!.products,
        );
        return;
      }

      final filteredList =
          state.selectedServiceProvider?.products!.where((services) {
        final service = services.productName?.toLowerCase();
        final input = query.toLowerCase();

        return service?.contains(input) == true;
      }).toList();

      state = state.copyWith(
        products: filteredList,
      );
    }
  }

  Future<void> postBillPayment(
      BuildContext context, String transactionPin) async {
    state = state.copyWith(isLoading: true);

    try {
      final amount = state.amountController.text;
      final biller = state.selectedServiceProvider;
      final product = state.selectedDataPlan;
      final profileData = ref.watch(loginProvider).loginResponse.value?.data;
      final deviceMetadata = ref.watch(deviceMetaProvider).asData?.value;
      final Position? location = await getCurrentPosition(context);

      var postBillPaymentRequest = PostBillPaymentRequest(
        username: profileData?.username,
        accountNo: profileData?.primaryAccountNo,
        deviceId: deviceMetadata?.deviceNumber,
        productCode: product?.productCode,
        ccy: profileData?.ccy ?? 'NGN',
        amount: num.tryParse(amount),
        charge: product?.charge ?? 0.00,
        narration: "data",
        merchantId: '',
        tranCode: TransactionCodes.data.jsonString,
        tranType: "Data",
        userId: "",
        mobileNo: state.phoneNumberController.text,
        paymentMethod: "CASH",
        serviceProvider: biller?.serviceProvider,
        billerCode: biller?.billerCode,
        terminalId: profileData?.terminalId,
        entityCode: profileData?.entityCode,
        cardData: 'Card',
        customerName: profileData?.fullname,
        billRefNo: biller?.billerRef,
        geolocation: location != null
            ? "${location.latitude},${location.longitude}"
            : "0,0",
        externalRefNo: generateExternalRefNo(),
        saveBeneficiary: state.isBeneficiary,
        channelType: "MOBILE",
      );

      var apiResponse = await RexApi.instance.postBillPayment(
        authToken: authToken,
        appVersion: ref.read(appVersionProvider),
        request: postBillPaymentRequest,
        transactionPin: transactionPin,
      );
      state = state.copyWith(
          isLoading: false, postBillPaymentSuccess: apiResponse.data);
    } catch (error, _) {
      state = state.copyWith(isLoading: false, apiError: error.toString());
    }
  }

  void fillBeneficiaryInfo(
      {required String phone, required String billerCode}) {
    state = state.copyWith(
      phoneNumberController: TextEditingController(text: phone),
      selectedServiceProvider: ref
          .read(billPaymentProvider)
          .dataBillers!
          .firstWhere((element) => element.billerCode == billerCode),
    );
  }

  void showDataPlan(BuildContext context) {
    if (state.selectedServiceProvider != null) {
      showSelectDataPlanModal(context);
    } else {
      context.showToast(message: StringAssets.selectNetworkProvider);
    }
  }

  ///This function allows me to reset the error field after it has been shown to
  ///the User so it does not pop up automatically when user retries
  void updateApiError() {
    state = state.copyWith(apiError: '');
  }
}
