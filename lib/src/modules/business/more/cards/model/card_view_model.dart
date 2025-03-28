import 'package:flutter/material.dart';
import 'package:rex_api/rex_api.dart';
import 'package:rex_app/src/modules/shared/models/state_lga_response.dart';

class CardsViewModel {
  final FocusNode cardOtpFocusNode;
  final GlobalKey cardOtpKey;
  final TextEditingController walletNumberController;
  final TextEditingController cardNameController;
  final TextEditingController addressController;
  final TextEditingController replacementCardPinController;
  final TextEditingController cardOtpController;
  final TextEditingController cardPasswordController;
  final TextEditingController cardNewPasswordController;
  final TextEditingController cardConfirmPasswordController;
  final TextEditingController createNewPinController;
  final TextEditingController createConfirmPinController;
  final ScrollController requestController;
  final List<String> deliveryOptions;
  final List<LGAsResponse>? stateLgaResponse;
  final List<CardProducts> cardProducts;
  final CardProducts? requestProducts;
  final CardResponse? requestResponse;
  final CardAction? cardActionResponse;
  final CardInfo? activateInfo;
  final String selectedCard;
  final String selectedDelivery;
  final String selectedBlockReason;
  final String selectedReplacementReason;
  final String selectedCity;
  final String selectedState;
  final String? cardOtpValidation;
  final bool obscureReplacePin;
  final bool obscureCurrentPassword;
  final bool obscureNewPassword;
  final bool obscureConfirmPassword;
  final bool obscureCreateNewPassword;
  final bool obscureCreateConfirmPassword;
  final bool isLoading;
  final double atmTransactionLimit;
  final double posTransactionLimit;
  final double onlineTransactionLimit;
  final List<CardListDetails> cards;
  final List<CardLimitDto> withdrawalRequest;
  final List<LookUpListInfo> cardBlockReasons;
  final List<LookUpListInfo> cardReplacementReasons;
  final WithdrawalResponse? withdrawalLimitResponse;
  final CardReplacementInfo? replacementInfo;
  final CardDetails? cardDetail;

  CardsViewModel({
    required this.cardOtpFocusNode,
    required this.cardOtpKey,
    required this.requestController,
    required this.walletNumberController,
    required this.cardNameController,
    required this.addressController,
    required this.replacementCardPinController,
    required this.cardOtpController,
    required this.cardPasswordController,
    required this.cardNewPasswordController,
    required this.cardConfirmPasswordController,
    required this.createNewPinController,
    required this.createConfirmPinController,
    required this.deliveryOptions,
    required this.stateLgaResponse,
    required this.cardDetail,
    required this.requestResponse,
    required this.requestProducts,
    required this.cardActionResponse,
    required this.withdrawalLimitResponse,
    required this.replacementInfo,
    required this.activateInfo,
    this.cards = const [],
    this.cardProducts = const [],
    this.withdrawalRequest = const [],
    this.cardBlockReasons = const [],
    this.cardReplacementReasons = const [],
    this.selectedCard = '',
    this.selectedDelivery = '',
    this.selectedBlockReason = '',
    this.selectedReplacementReason = '',
    this.selectedCity = '',
    this.selectedState = '',
    this.obscureReplacePin = false,
    this.obscureCurrentPassword = false,
    this.obscureNewPassword = false,
    this.obscureConfirmPassword = false,
    this.obscureCreateNewPassword = false,
    this.obscureCreateConfirmPassword = false,
    this.isLoading = false,
    this.atmTransactionLimit = 0,
    this.posTransactionLimit = 0,
    this.onlineTransactionLimit = 0,
    required this.cardOtpValidation,
  });

  CardsViewModel copyWith({
    List<CardListDetails>? cards,
    CardDetails? cardDetail,
    ScrollController? requestController,
    FocusNode? cardOtpFocusNode,
    GlobalKey? cardOtpKey,
    CardProducts? requestProducts,
    CardResponse? requestResponse,
    CardAction? cardActionResponse,
    CardInfo? activateInfo,
    CardReplacementInfo? replacementInfo,
    WithdrawalResponse? withdrawalLimitResponse,
    TextEditingController? walletNumberController,
    TextEditingController? cardNameController,
    TextEditingController? addressController,
    TextEditingController? replacementCardPinController,
    TextEditingController? cardOtpController,
    TextEditingController? cardPasswordController,
    TextEditingController? cardNewPasswordController,
    TextEditingController? cardConfirmPasswordController,
    TextEditingController? createNewPinController,
    TextEditingController? createConfirmPinController,
    List<String>? deliveryOptions,
    List<LGAsResponse>? stateLgaResponse,
    List<CardProducts>? cardProducts,
    List<CardLimitDto>? withdrawalRequest,
    List<LookUpListInfo>? cardBlockReasons,
    List<LookUpListInfo>? cardReplacementReasons,
    String? selectedCard,
    String? selectedDelivery,
    String? selectedBlockReason,
    String? selectedReplacementReason,
    String? selectedCity,
    String? selectedState,
    String? cardOtpValidation,
    bool? obscureReplacePin,
    bool? obscureCurrentPassword,
    bool? obscureNewPassword,
    bool? obscureConfirmPassword,
    bool? obscureCreateNewPassword,
    bool? obscureCreateConfirmPassword,
    bool? isLoading,
    double? atmTransactionLimit,
    double? posTransactionLimit,
    double? onlineTransactionLimit,
  }) {
    return CardsViewModel(
      cards: cards ?? this.cards,
      cardDetail: cardDetail ?? this.cardDetail,
      isLoading: isLoading ?? this.isLoading,
      requestController: requestController ?? this.requestController,
      cardOtpFocusNode: cardOtpFocusNode ?? this.cardOtpFocusNode,
      cardOtpKey: cardOtpKey ?? this.cardOtpKey,
      requestProducts: requestProducts ?? this.requestProducts,
      cardActionResponse: cardActionResponse ?? this.cardActionResponse,
      withdrawalRequest: withdrawalRequest ?? this.withdrawalRequest,
      cardBlockReasons: cardBlockReasons ?? this.cardBlockReasons,
      cardReplacementReasons: cardReplacementReasons ?? this.cardReplacementReasons,
      requestResponse: requestResponse ?? this.requestResponse,
      replacementInfo: replacementInfo ?? this.replacementInfo,
      activateInfo: activateInfo ?? this.activateInfo,
      withdrawalLimitResponse: withdrawalLimitResponse ?? this.withdrawalLimitResponse,
      walletNumberController:
          walletNumberController ?? this.walletNumberController,
      cardNameController: cardNameController ?? this.cardNameController,
      addressController: addressController ?? this.addressController,
      replacementCardPinController: replacementCardPinController ?? this.replacementCardPinController,
      cardOtpController: cardOtpController ?? this.cardOtpController,
      cardPasswordController: cardPasswordController ?? this.cardPasswordController,
      cardNewPasswordController: cardNewPasswordController ?? this.cardNewPasswordController,
      cardConfirmPasswordController: cardConfirmPasswordController ?? this.cardConfirmPasswordController,
      createNewPinController: createNewPinController ?? this.createNewPinController,
      createConfirmPinController: createConfirmPinController ?? this.createConfirmPinController,
      cardProducts: cardProducts ?? this.cardProducts,
      deliveryOptions: deliveryOptions ?? this.deliveryOptions,
      stateLgaResponse: stateLgaResponse ?? this.stateLgaResponse,
      selectedCard: selectedCard ?? this.selectedCard,
      selectedDelivery: selectedDelivery ?? this.selectedDelivery,
      selectedBlockReason: selectedBlockReason ?? this.selectedBlockReason,
      selectedReplacementReason: selectedReplacementReason ?? this.selectedReplacementReason,
      selectedCity: selectedCity ?? this.selectedCity,
      selectedState: selectedState ?? this.selectedState,
      obscureReplacePin: obscureReplacePin ?? this.obscureReplacePin,
      obscureCurrentPassword: obscureCurrentPassword ?? this.obscureCurrentPassword,
      obscureNewPassword: obscureNewPassword ?? this.obscureNewPassword,
      obscureConfirmPassword: obscureConfirmPassword ?? this.obscureConfirmPassword,
      obscureCreateNewPassword: obscureCreateNewPassword ?? this.obscureCreateNewPassword,
      obscureCreateConfirmPassword: obscureCreateConfirmPassword ?? this.obscureCreateConfirmPassword,
      cardOtpValidation: cardOtpValidation ?? this.cardOtpValidation,
      atmTransactionLimit: atmTransactionLimit ?? this.atmTransactionLimit,
      posTransactionLimit: posTransactionLimit ?? this.posTransactionLimit,
      onlineTransactionLimit: onlineTransactionLimit ?? this.onlineTransactionLimit,
    );
  }
}
