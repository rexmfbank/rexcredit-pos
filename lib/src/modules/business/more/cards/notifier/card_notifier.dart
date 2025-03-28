import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:rex_api/rex_api.dart';
import 'package:rex_app/src/config/app_config.dart';
import 'package:rex_app/src/config/routes/route_name.dart';
import 'package:rex_app/src/modules/business/more/cards/model/card_view_model.dart';
import 'package:rex_app/src/modules/business/more/cards/ui/block_card_page.dart';
import 'package:rex_app/src/modules/business/more/cards/ui/card_details_page.dart';
import 'package:rex_app/src/modules/business/more/cards/ui/card_otp_screen.dart';
import 'package:rex_app/src/modules/business/more/cards/ui/debit_card_options_page.dart';
import 'package:rex_app/src/modules/business/more/cards/ui/request_sent_page.dart';
import 'package:rex_app/src/modules/shared/models/state_lga_response.dart';
import 'package:rex_app/src/modules/shared/models/text_field_validator.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/modal_bottom_sheets/show_modal_action.dart';
import 'package:rex_app/src/utils/constants/asset_path.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/navigation.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';
import 'package:rex_app/src/utils/enums/card_block_reasons.dart';
import 'package:rex_app/src/utils/enums/enums.dart';
import 'package:rex_app/src/utils/extensions/extension_on_string.dart';

final cardNotifier =
    NotifierProvider<CardNotifier, CardsViewModel>(() => CardNotifier());

class CardNotifier extends Notifier<CardsViewModel> {
  @override
  CardsViewModel build() => CardsViewModel(
        cardOtpFocusNode: FocusNode(),
        cardOtpKey: GlobalKey(),
        requestController: ScrollController(),
        cardOtpController: TextEditingController(),
        walletNumberController: TextEditingController(),
        cardNameController: TextEditingController(),
        addressController: TextEditingController(),
        replacementCardPinController: TextEditingController(),
        cardPasswordController: TextEditingController(),
        cardNewPasswordController: TextEditingController(),
        cardConfirmPasswordController: TextEditingController(),
        createNewPinController: TextEditingController(),
        createConfirmPinController: TextEditingController(),
        withdrawalLimitResponse: null,
        cardOtpValidation: null,
        cardDetail: null,
        requestProducts: null,
        requestResponse: null,
        cardActionResponse: null,
        replacementInfo: null,
        activateInfo: null,
        deliveryOptions: [
          DeliveryOption.delivery.displayString,
          DeliveryOption.pickup.displayString,
        ],
        stateLgaResponse: [],
      );

  void initialize() async {
    final json = await getStatesAndLocals();
    state = state.copyWith(
      stateLgaResponse: stateCapitalResponseFromJson(json),
      walletNumberController:
          TextEditingController(text: ref.read(userNubanProvider)),
    );
  }

  Future<dynamic> getStatesAndLocals() async {
    final statesAndLocals = await rootBundle.loadString(JsonAsset.statesLga);

    return jsonDecode(statesAndLocals);
  }

  void disposeCardOTPController() =>
      state = state.copyWith(cardOtpController: TextEditingController());

  void cardOTPValidator() => state = state.copyWith(
        cardOtpValidation: TextfieldValidator.otpValidator(
          state.cardOtpController.text,
        ),
      );

  void onCardOtpTap() => state = state.copyWith(cardOtpValidation: null);

  bool cardOtpValidationCheck() {
    if (state.cardOtpValidation.isBlank) {
      return true;
    }
    return false;
  }

  void updateCardType(String? value) =>
      state = state.copyWith(selectedCard: value);

  void updateDeliveryOption(String? value) =>
      state = state.copyWith(selectedDelivery: value);

  void updateSelectedProduct(String? value) {
    if (value.isNotBlank) {
      final List<String> product = value!.split('-');
      state = state.copyWith(
        requestProducts: state.cardProducts
            .firstWhere((element) => element.productName == product[0].trim()),
        selectedCard: value,
      );
    }
  }

  void updateBlockedReason(String? value) =>
      state = state.copyWith(selectedBlockReason: value);

  void updateReplacementReason(String? value) =>
      state = state.copyWith(selectedReplacementReason: value);

  void updateSelectedState(String? value) =>
      state = state.copyWith(selectedState: value);

  void updateSelectedCity(String? value) =>
      state = state.copyWith(selectedCity: value);

  // void showExpiryDatePicker(BuildContext context) => showMonthPicker(
  //       context: context,
  //       initialDate: DateTime(
  //           DateTime.now().year + 1, DateTime.now().month, DateTime.now().day),
  //       firstDate: DateTime(
  //           DateTime.now().year + 1, DateTime.now().month, DateTime.now().day),
  //       lastDate: DateTime(2053),
  //     ).then((value) {
  //       ref.read(cardNotifier.notifier).updateActivateExpiryDate(
  //           DateFormat('M/y').format(value ?? DateTime.now()));
  //     });

  void navigateToRequest(BuildContext context) => context.push(
        "${RouteName.dashboardMoreBusiness}/${RouteName.requestCards}",
      );

  void toggleReplacementCurrentPin() =>
      state = state.copyWith(obscureReplacePin: !state.obscureReplacePin);

  void toggleResetCurrentPin() => state =
      state.copyWith(obscureCurrentPassword: !state.obscureCurrentPassword);

  void toggleResetNewPin() =>
      state = state.copyWith(obscureNewPassword: !state.obscureNewPassword);

  void toggleResetConfirmPin() => state =
      state.copyWith(obscureConfirmPassword: !state.obscureConfirmPassword);

  void toggleCreateNewPin() => state =
      state.copyWith(obscureCreateNewPassword: !state.obscureCreateNewPassword);

  void toggleCreateConfirmPin() => state = state.copyWith(
      obscureCreateConfirmPassword: !state.obscureCreateConfirmPassword);

  void updateAtmTransactionLimit(double value) {
    state = state.copyWith(atmTransactionLimit: value);
    updateWithdrawalLimit(
      CardLimitDto(
        limitType: LimitTypes.atmLimit.jsonString,
        maxLimit: value,
      ),
    );
  }

  void updatePosTransactionLimit(double value) {
    state = state.copyWith(posTransactionLimit: value);
    updateWithdrawalLimit(
      CardLimitDto(
        limitType: LimitTypes.posLimit.jsonString,
        maxLimit: value,
      ),
    );
  }

  void updateOnlineTransactionLimit(double value) {
    state = state.copyWith(onlineTransactionLimit: value);
    updateWithdrawalLimit(
      CardLimitDto(
        limitType: LimitTypes.webLimit.jsonString,
        maxLimit: value,
      ),
    );
  }

  void getCards(BuildContext context) async {
    state = state.copyWith(isLoading: true);

    try {
      var apiResponse = await RexApi.instance.getCardList(
        authToken: ref.read(userAuthTokenProvider) ?? '',
        appVersion: ref.read(appVersionProvider),
      );

      state = state.copyWith(isLoading: false, cards: apiResponse.data);
    } catch (error, _) {
      state = state.copyWith(isLoading: false);
      if (context.mounted) {
        showModalActionError(
            context: context, errorText: "vcvcvcvccv" //error.toString(),
            );
      }
      if (kDebugMode) {
        print('Cards Notifier Error: $error');
      }
    }
  }

  void getCardDetails({
    required BuildContext context,
    required String cardID,
  }) async {
    state = state.copyWith(isLoading: true);

    try {
      var apiResponse = await RexApi.instance.getCardDetails(
        authToken: ref.read(userAuthTokenProvider) ?? '',
        appVersion: ref.read(appVersionProvider),
        cardID: cardID,
      );

      state = state.copyWith(
        isLoading: false,
        cardDetail: apiResponse.data,
        atmTransactionLimit:
            double.parse(apiResponse.data?.product?.minLimit ?? '0'),
        posTransactionLimit:
            double.parse(apiResponse.data?.product?.minLimit ?? '0'),
        onlineTransactionLimit:
            double.parse(apiResponse.data?.product?.minLimit ?? '0'),
      );
    } catch (error, _) {
      state = state.copyWith(isLoading: false);
      if (context.mounted) {
        showModalActionError(
          context: context,
          errorText: "Sorry, there is an error",
        );
      }
      if (kDebugMode) {
        print('Cards Notifier Error: $error');
      }
    }
  }

  void getCardProducts(BuildContext context) async {
    state = state.copyWith(isLoading: true);
    try {
      var apiResponse = await RexApi.instance.getCardProducts(
        authToken: ref.read(userAuthTokenProvider) ?? '',
        appVersion: ref.read(appVersionProvider),
      );

      state = state.copyWith(isLoading: false, cardProducts: apiResponse.data);
    } catch (error, _) {
      state = state.copyWith(isLoading: false);
      if (context.mounted) {
        showModalActionError(
          context: context,
          errorText: error.toString(),
        );
      }
      if (kDebugMode) {
        print('Cards Notifier Product Error: $error');
      }
    }
  }

  void requestCard({required BuildContext context}) async {
    state = state.copyWith(isLoading: true);
    try {
      var apiResponse = await RexApi.instance.postCardRequest(
        authToken: ref.read(userAuthTokenProvider) ?? '',
        appVersion: ref.read(appVersionProvider),
        request: CardRequest(
          accountNo: state.walletNumberController.text,
          cardType: state.requestProducts?.cardType?.jsonString ?? '',
          deliveryOption: state.selectedDelivery,
          address: state.addressController.text,
          city: state.selectedCity,
          state: state.selectedState,
          cardProductCode: state.requestProducts?.productCode ?? '',
          cardName: state.cardNameController.text,
          reference: AppConstants.guid(),
          externalReferenceNo: AppConstants.guid(),
        ),
      );

      state =
          state.copyWith(isLoading: false, requestResponse: apiResponse.data);
      if (context.mounted) {
        alternateRouteToRequestSuccess(
            context: context,
            title: StringAssets.requestSent,
            info: StringAssets.requestSuccessfullySubmitted,
            onTap: () {
              context.pop();
              context.pop();
              getCards(context);
              getCardProducts(context);
            });
      }
    } catch (error, _) {
      state = state.copyWith(isLoading: false);
      if (context.mounted) {
        showModalActionError(
          context: context,
          errorText: error.toString(),
        );
      }
      if (kDebugMode) {
        print('Cards Notifier Error: $error');
      }
    }
  }

  void performCardAction({required BuildContext context, required bool value}) {
    if (value) {
      performUnblockAction(context);
      return;
    }
    ref.watch(cardNotifier.notifier).performBlockAction(context);
  }

  void getBlockReasons(BuildContext context) async {
    state = state.copyWith(isLoading: true);
    try {
      var apiResponse = await RexApi.instance.fetchBaLookupData(
        authToken: ref.read(userAuthTokenProvider) ?? '',
        query: LookupListQuery(
          lookupCode: CategoryCode.codeBlockReasonCode.jsonString,
        ),
      );

      state =
          state.copyWith(isLoading: false, cardBlockReasons: apiResponse.data);
    } catch (error, _) {
      state = state.copyWith(isLoading: false);
      if (context.mounted) {
        showModalActionError(
          context: context,
          errorText: error.toString(),
        );
      }
      if (kDebugMode) {
        print('Card Block Response Error: $error');
      }
    }
  }

  void performBlockAction(BuildContext context) async {
    state = state.copyWith(isLoading: true);
    try {
      var apiResponse = await RexApi.instance.blockCard(
        authToken: ref.read(userAuthTokenProvider) ?? '',
        appVersion: ref.read(appVersionProvider),
        request: CardActionRequest(
          cardId: state.cardDetail?.cardId ?? '',
          reason: state.selectedBlockReason,
        ),
      );

      state = state.copyWith(
          isLoading: false, cardActionResponse: apiResponse.data);
      if (context.mounted) {
        navigateToRequestSuccess(
          context: context,
          title: StringAssets.cardBlocked,
          info: StringAssets.debitCardBlocked,
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
      if (kDebugMode) {
        print('Cards Block Error: $error');
      }
    }
  }

  void performUnblockAction(BuildContext context) async {
    state = state.copyWith(isLoading: true);
    try {
      var apiResponse = await RexApi.instance.unblockCard(
        authToken: ref.read(userAuthTokenProvider) ?? '',
        appVersion: ref.read(appVersionProvider),
        request: CardActionRequest(
          cardId: state.cardDetail?.cardId ?? '',
          reason: StringAssets.unblock,
        ),
      );

      state = state.copyWith(
          isLoading: false, cardActionResponse: apiResponse.data);
      if (context.mounted) {
        navigateToRequestSuccess(
          context: context,
          title: StringAssets.cardUnblocked,
          info: StringAssets.debitCardUnblocked,
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
      if (kDebugMode) {
        print('Cards Block Error: $error');
      }
    }
  }

  void requestChangePinOTP({
    required BuildContext context,
    required VoidCallback onSuccess,
  }) async {
    state = state.copyWith(isLoading: true);
    try {
      await RexApi.instance.resetPinRequest(
        authToken: ref.read(userAuthTokenProvider) ?? '',
        cardId: state.cards[0].cardId.toString(),
      );

      state = state.copyWith(isLoading: false);
      onSuccess.call();
    } catch (error, _) {
      state = state.copyWith(isLoading: false);
      if (context.mounted) {
        showModalActionError(
          context: context,
          errorText: error.toString(),
        );
      }
      if (kDebugMode) {
        print('Cards Request OTP Error: $error');
      }
    }
  }

  void verifyChangePinOTP(
      {required BuildContext context, required VoidCallback onSuccess}) async {
    state = state.copyWith(isLoading: true);
    try {
      await RexApi.instance.verifyCardOTP(
        authToken: ref.read(userAuthTokenProvider) ?? '',
        request: VerifyCardOtpRequest(
          cardId: state.cards[0].cardId.toString() ?? '',
          otp: state.cardOtpController.text,
        ),
      );

      state = state.copyWith(isLoading: false);
      onSuccess.call();
    } catch (error, _) {
      state = state.copyWith(isLoading: false);
      if (context.mounted) {
        showModalActionError(
          context: context,
          errorText: error.toString(),
        );
      }
      if (kDebugMode) {
        print('Cards Request OTP Error: $error');
      }
    }
  }

  void changePin({
    required BuildContext context,
    required String oldPin,
    required String newPin,
    required VoidCallback onSuccess,
  }) async {
    state = state.copyWith(isLoading: true);
    try {
      await RexApi.instance.setCardPin(
        authToken: ref.read(userAuthTokenProvider) ?? '',
        appVersion: ref.read(appVersionProvider),
        request: ChangeCardPinRequest(
          cardId: state.cards[0].cardId.toString() ?? '',
          otp: state.cardOtpController.text,
          oldPin: oldPin,
          newPin: newPin,
        ),
      );

      state = state.copyWith(isLoading: false);
      onSuccess.call();
    } catch (error, _) {
      state = state.copyWith(isLoading: false);
      if (context.mounted) {
        showModalActionError(
          context: context,
          errorText: error.toString(),
        );
      }
      if (kDebugMode) {
        print('Cards Request OTP Error: $error');
      }
    }
  }

  void createPin(BuildContext context) async {
    state = state.copyWith(isLoading: true);
    try {
      await RexApi.instance.setCardPin(
        authToken: ref.read(userAuthTokenProvider) ?? '',
        appVersion: ref.read(appVersionProvider),
        request: ChangeCardPinRequest(
          cardId: state.cards[0].cardId.toString() ?? '',
          otp: state.cardOtpController.text,
          oldPin: '',
          newPin: state.createConfirmPinController.text,
        ),
      );

      state = state.copyWith(isLoading: false);
      if (context.mounted) {
        alternateRouteToRequestSuccess(
          context: context,
          title: StringAssets.cardPinActivated,
          info: StringAssets.cardPinActivatedPrompt,
          onTap: () => navigateBackFour(context),
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
      if (kDebugMode) {
        print('Create Card Pin Error: $error');
      }
    }
  }

  void updateWithdrawalLimit(CardLimitDto value) {
    List<CardLimitDto> withdrawalLimits = state.withdrawalRequest;
    if (state.withdrawalRequest
        .any((element) => element.limitType == value.limitType)) {
      withdrawalLimits = state.withdrawalRequest
        ..removeWhere((element) => element.limitType == value.limitType);
    }
    withdrawalLimits = state.withdrawalRequest.toList()..add(value);
    state = state.copyWith(withdrawalRequest: withdrawalLimits);
  }

  void setWithdrawalLimit({required BuildContext context}) async {
    state = state.copyWith(isLoading: true);
    try {
      var apiResponse = await RexApi.instance.setCardWithdrawalLimit(
        authToken: ref.read(userAuthTokenProvider) ?? '',
        appVersion: ref.read(appVersionProvider),
        request: SetCardWithdrawalLimitRequest(
          cardId: state.cards[0].cardId.toString() ?? '',
          cardLimitDtoList: state.withdrawalRequest,
        ),
      );

      state = state.copyWith(
        isLoading: false,
        withdrawalLimitResponse: apiResponse.data,
      );
      if (context.mounted) {
        alternateRouteToRequestSuccess(
          context: context,
          title: StringAssets.cardTransactionLimitSet,
          info: StringAssets.cardTransactionLimitSetPrompt,
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
      if (kDebugMode) {
        print('Cards Withdrawal Limit Error: $error');
      }
    }
  }

  void getReplacementReasons(BuildContext context) async {
    state = state.copyWith(isLoading: true);
    try {
      var apiResponse = await RexApi.instance.fetchBaLookupData(
        authToken: ref.read(userAuthTokenProvider) ?? '',
        query: LookupListQuery(
          lookupCode: CategoryCode.codeReplacementReasonCode.jsonString,
        ),
      );

      state = state.copyWith(
          isLoading: false, cardReplacementReasons: apiResponse.data);
    } catch (error, _) {
      state = state.copyWith(isLoading: false);
      if (context.mounted) {
        showModalActionError(
          context: context,
          errorText: error.toString(),
        );
      }
      if (kDebugMode) {
        print('Card Block Response Error: $error');
      }
    }
  }

  void performCardReplacement(BuildContext context) async {
    state = state.copyWith(isLoading: true);
    try {
      var apiResponse = await RexApi.instance.postCardReplacement(
        authToken: ref.read(userAuthTokenProvider) ?? '',
        request: CardReplacementRequest(
          reason: state.selectedReplacementReason,
          cardId: state.cardDetail?.cardId ?? '',
          externalRefNo: AppConstants.guid(),
          cardPin: state.replacementCardPinController.text,
        ),
      );

      state =
          state.copyWith(isLoading: false, replacementInfo: apiResponse.data);
      if (context.mounted) {
        alternateRouteToRequestSuccess(
          context: context,
          title: StringAssets.requestSent,
          info: StringAssets.requestSuccessfullySubmitted,
          onTap: () => navigateBackThree(context),
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
      if (kDebugMode) {
        print('Cards Block Error: $error');
      }
    }
  }

  void performNavigateCreatePin(BuildContext context) {
    requestChangePinOTP(
      context: context,
      onSuccess: () => navigateToOTP(
        context: context,
        onComplete: () => verifyChangePinOTP(
          context: context,
          onSuccess: () => navigateToCreatePin(context),
        ),
      ),
    );
  }

  void performNavigateChangePin(BuildContext context) {
    requestChangePinOTP(
      context: context,
      onSuccess: () => navigateToOTP(
        context: context,
        onComplete: () => verifyChangePinOTP(
          context: context,
          onSuccess: () => navigateToChangePin(context),
        ),
      ),
    );
  }

  void performChangePinAction(BuildContext context) {
    changePin(
      context: context,
      oldPin: state.cardPasswordController.text,
      newPin: state.cardNewPasswordController.text,
      onSuccess: () => alternateRouteToRequestSuccess(
        context: context,
        title: StringAssets.cardPinCreated,
        info: StringAssets.cardPinCreatedPrompt,
        onTap: () => navigateBackThree(context),
      ),
    );
  }

  void validateRequestCard(BuildContext context) {
    if (state.cardNameController.text.isNotBlank &&
        state.requestProducts != null &&
        state.selectedDelivery.isNotBlank &&
        state.addressController.text.isNotBlank &&
        state.selectedState.isNotBlank &&
        state.selectedCity.isNotBlank) {
      navigateToRequestSummary(context);
      return;
    }
    showModalActionError(
      context: context,
      title: StringAssets.validationError,
      errorText: StringAssets.pleaseFillAllFields,
    );
  }

  void validateReplaceCard(BuildContext context) {
    if (state.replacementCardPinController.text.isNotBlank &&
        state.selectedReplacementReason.isNotBlank) {
      performCardReplacement(context);
      return;
    }
    showModalActionError(
      context: context,
      title: StringAssets.validationError,
      errorText: StringAssets.pleaseFillAllFields,
    );
  }

  void navigateToCardList(BuildContext context) => context.push(
        "${RouteName.dashboardMoreBusiness}/${RouteName.cards}",
      );

  void navigateToRequestSummary(BuildContext context) =>
      context.pushReplacement(
        "${RouteName.dashboardMoreBusiness}/${RouteName.cardRequestSummary}",
      );

  void navigateToCreatePin(BuildContext context) => context.push(
        "${RouteName.dashboardMoreBusiness}/${RouteName.createCardPin}",
      );

  void navigateToChangePin(BuildContext context) => context.push(
        "${RouteName.dashboardMoreBusiness}/${RouteName.resetCardPin}",
      );

  void navigateToActivateCard(BuildContext context) => context.push(
        "${RouteName.dashboardMoreBusiness}/${RouteName.activateCardPage}",
      );

  void navigateToCardTransactionLimit(BuildContext context) => context.push(
        "${RouteName.dashboardMoreBusiness}/${RouteName.cardTransactionLimit}",
      );

  void navigateToCardReplacement(BuildContext context) => context.push(
        "${RouteName.dashboardMoreBusiness}/${RouteName.cardReplacementPage}",
      );

  void navigateBackTwo(BuildContext context) {
    context.pop();
    context.pop();
  }

  void navigateBackThree(BuildContext context) {
    context.pop();
    context.pop();
    context.pop();
  }

  void navigateBackFour(BuildContext context) {
    context.pop();
    context.pop();
    context.pop();
    context.pop();
  }

  void navigateToRequestSuccess({
    required BuildContext context,
    required String title,
    required String info,
    VoidCallback? onTap,
  }) =>
      context.pushReplacementSuper(
        RequestSentPage(
          title: title,
          info: info,
          onTap: onTap,
        ),
      );

  void alternateRouteToRequestSuccess({
    required BuildContext context,
    required String title,
    required String info,
    VoidCallback? onTap,
  }) =>
      context.pushSuper(
        RequestSentPage(
          title: title,
          info: info,
          onTap: onTap,
        ),
      );

  void navigateToCardOptions({
    required BuildContext context,
    required CardListDetails model,
  }) =>
      context.pushSuper(
        DebitCardOptionsPage(
          card: model,
        ),
      );

  void navigateToOTP({
    required BuildContext context,
    required VoidCallback onComplete,
  }) =>
      context.pushSuper(
        CardOtpScreen(
          onComplete: onComplete,
        ),
      );

  void navigateToCardDetails({
    required BuildContext context,
    required CardDetails model,
  }) =>
      context.pushSuper(
        CardDetailsPage(
          model: model,
        ),
      );

  void navigateToBlockCard({
    required BuildContext context,
    required CardListDetails model,
  }) =>
      context.pushSuper(
        BlockCardPage(
          model: model,
        ),
      );

  void scrollToBottom() => state.requestController
      .jumpTo(state.requestController.position.maxScrollExtent);
}
