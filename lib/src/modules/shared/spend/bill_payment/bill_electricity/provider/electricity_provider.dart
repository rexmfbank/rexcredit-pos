import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/utils/data/rex_api/rex_api.dart';
import 'package:rex_app/src/modules/revamp/login/providers/login_provider.dart';
import 'package:rex_app/src/modules/shared/spend/bill_payment/bill_electricity/states/electricity_screen_state.dart';
import 'package:rex_app/src/modules/shared/spend/bill_payment/shared/providers/bill_payment_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/extension/snack_bar_ext.dart';
import 'package:rex_app/src/modules/shared/widgets/modal_bottom_sheets/show_modal_action.dart';
import 'package:rex_app/src/modules/shared/widgets/modal_bottom_sheets/show_status_modal_sheet.dart';
import 'package:rex_app/src/utils/extensions/extension_on_string.dart';
import 'package:rex_app/src/utils/mixin/locator_mixin.dart';

import '../../../../../revamp/utils/config/routes/route_name.dart';
import '../../../../../../utils/constants/string_assets.dart';
import '../../../../../../utils/enums/enums.dart';
import '../../../../../../utils/string_utils.dart';
import '../../../../../shared/providers/app_preference_provider.dart';
import '../../../../../shared/providers/meta_data_provider.dart';
import '../../../../../shared/widgets/modal_bottom_sheets/show_confirm_pin_modal_sheet.dart';
import '../../shared/widgets/show_modal_choose_payment_method.dart';

final electricityProvider = StateNotifierProvider.autoDispose<
    ElectricityNotifier, ElectricityScreenState>((ref) {
  var authToken = ref.watch(appAuthTokenProvider) ?? '';
  return ElectricityNotifier(authToken, ref);
});

class ElectricityNotifier extends StateNotifier<ElectricityScreenState>
    with LocatorMix {
  ElectricityNotifier(this.authToken, this.ref)
      : super(ElectricityScreenState.initial());

  final String authToken;
  final StateNotifierProviderRef<ElectricityNotifier, ElectricityScreenState>
      ref;

  void setSelectedServiceProvider(Biller biller) {
    state = state.copyWith(
      selectedServiceProvider: biller,
      billerNameController: TextEditingController(text: biller.billerName),
      billerProducts: biller.products,
    );
  }

  void setSelectedMeterType(
      {required BuildContext context,
      required String meterProduct,
      required BillerProduct product}) {
    state = state.copyWith(
      meterTypeController: TextEditingController(text: meterProduct),
      selectedBillerProduct: product,
      searchMeterTypeController: TextEditingController(),
    );
    filterMeterType(state.searchMeterTypeController.text);
    if (state.meterNumberController.text.isNotEmpty) {
      validateMeterNo(context);
    }
  }

  void filterMeterType(String query) {
    if (state.selectedServiceProvider != null &&
        state.selectedServiceProvider?.products != null &&
        state.selectedServiceProvider!.products!.isNotEmpty) {
      if (query.isEmpty) {
        state = state.copyWith(
          billerProducts: state.selectedServiceProvider!.products,
        );
        return;
      }

      final filteredList =
          state.selectedServiceProvider?.products!.where((productList) {
        final products = productList.productName?.toLowerCase();
        final input = query.toLowerCase();

        return products?.contains(input) == true;
      }).toList();

      state = state.copyWith(
        billerProducts: filteredList,
      );
    }
  }

  void setIsBeneficiary(bool value) {
    state = state.copyWith(isBeneficiary: value);
  }

  void clearFormError() => state = state.copyWith(formError: '');

  void fillBeneficiaryInfo(
      {required String meterNumber, required String billerCode}) {
    state = state.copyWith(
      billerNameController: TextEditingController(
          text: ref
              .read(billPaymentProvider)
              .electricBillers!
              .firstWhere((element) => element.billerCode == billerCode)
              .billerName),
      meterNumberController: TextEditingController(text: meterNumber),
      selectedServiceProvider: ref
          .read(billPaymentProvider)
          .electricBillers!
          .firstWhere((element) => element.billerCode == billerCode),
    );
  }

  void showPaymentMethodModal(BuildContext context) {
    showModalChoosePaymentMethod(
      context: context,
      onNextTapped: () {
        showConfirmPinModalSheet(
          context: context,
          title: StringAssets.confirmElectricity,
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

  Future<void> validateMeterNo(BuildContext context) async {
    state = state.copyWith(validateMeterNoLoading: true);
    try {
      final biller = state.selectedServiceProvider;
      final profileData = ref.watch(loginProvider).loginResponse.value?.data;
      final validateBill = ValidateBillRequest(
        entityCode: profileData?.entityCode,
        billerCode: biller?.billerCode ?? '',
        productCode: state.selectedBillerProduct?.productCode ?? '',
        referenceNo: state.meterNumberController.text,
        amount: state.amountController.text,
        countryCode: biller?.countryCode,
        serviceProvider: biller?.serviceProvider,
      );

      var apiResponse = await RexApi.instance
          .validateBill(authToken: authToken, request: validateBill);

      state = state.copyWith(
          validateMeterNoLoading: false, validateBillData: apiResponse.data);
    } catch (error, _) {
      state = state.copyWith(
          validateMeterNoLoading: false, apiError: error.toString());
      if (context.mounted) {
        context.showToast(message: error.toString());
      }
    }
  }

  Future<void> postBillPayment(
    BuildContext context,
    String transactionPin,
  ) async {
    state = state.copyWith(isLoading: true);
    try {
      final validateBillData = state.validateBillData;
      final amount = state.amountController.text;
      final biller = state.selectedServiceProvider;
      final profileData = ref.watch(loginProvider).loginResponse.value?.data;
      final deviceMetadata = ref.watch(deviceMetaProvider).asData?.value;
      final Position? location = await getCurrentPosition(context);

      var postBillPaymentRequest = PostBillPaymentRequest(
        username: profileData?.username,
        accountNo: profileData?.primaryAccountNo,
        deviceId: deviceMetadata?.deviceNumber,
        productCode: state.selectedBillerProduct?.productCode ?? '',
        ccy: profileData?.ccy ?? 'NGN',
        address: profileData?.address ?? '',
        amount: num.tryParse(amount),
        charge: 0.00,
        narration: "electricity",
        merchantId: "",
        tranCode: TransactionCodes.power.jsonString,
        tranType: BillerCategories.electricity.jsonString,
        userId: "",
        mobileNo: validateBillData?.mobileNo,
        paymentMethod: "CASH",
        serviceProvider: biller?.serviceProvider,
        billerCode: biller?.billerCode,
        terminalId: profileData?.terminalId,
        entityCode: profileData?.entityCode,
        cardData: null,
        customerName: validateBillData?.customerName,
        billRefNo: state.meterNumberController.text,
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
        isLoading: false,
        postBillPaymentSuccess: apiResponse.data,
      );
      if (context.mounted) {
        showStatusModal(
          context: context,
          title: StringAssets.electricityPaymentSuccessful,
          subtitle: StringAssets.electricityPaymentSuccessfulInfo(
            amount: amount,
            meterNo: state.meterNumberController.text,
            token: apiResponse.data?.id ?? '',
          ),
          buttonText: StringAssets.ok,
          isSuccess: true,
          onButtonPressed: () {
            Clipboard.setData(
              ClipboardData(
                text: apiResponse.data?.id ?? '',
              ),
            ).then(
              (value) => context.showToast(
                message: StringAssets.accountNumberCopied,
              ),
            );
            ref.read(billPaymentProvider.notifier).popUp(context);
          },
          onCloseTapped: () {
            Clipboard.setData(
              ClipboardData(
                text: apiResponse.data?.id ?? '',
              ),
            ).then(
              (value) => context.showToast(
                message: StringAssets.accountNumberCopied,
              ),
            );
            ref.read(billPaymentProvider.notifier).popUp(context);
          },
        );
      }
    } catch (error, _) {
      state = state.copyWith(isLoading: false);
      if (context.mounted) {
        showModalActionError(
          context: context,
          errorText: error.toString(),
        );
      }
    }
  }

  ///This function allows me to reset the error field after it has been shown to
  ///the User so it does not pop up automatically when user retries
  void resetApiError() {
    state = state.copyWith(apiError: '');
  }

  void validateElectricity(BuildContext context) {
    final amount = state.amountController.text;
    final meterNo = state.meterNumberController.text;
    final meterName = state.validateBillData?.customerName;
    final meterType = state.meterTypeController.text;

    if (state.selectedServiceProvider == null) {
      state = state.copyWith(formError: StringAssets.selectServiceProvider);
      return;
    }

    if (meterType.isBlank) {
      state = state.copyWith(formError: StringAssets.selectMeterType);
      return;
    }

    if (meterNo.isBlank || meterNo.length < 9) {
      state = state.copyWith(formError: StringAssets.invalidMeterNo);
      return;
    }

    if (meterName.isBlank) {
      state = state.copyWith(formError: StringAssets.invalidMeterName);
      return;
    }

    if (amount.isBlank) {
      state = state.copyWith(formError: StringAssets.invalidAmount);
      return;
    }

    context.push("${Routes.dashboardSpend}/${Routes.billElectricityConfirm}");
  }
}
