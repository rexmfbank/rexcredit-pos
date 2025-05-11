import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/data/rex_api/rex_api.dart';

class TargetSavingState extends Equatable {
  final bool? isYesChecked;
  final bool autoSave;
  final bool? isNoChecked;
  final DateTime? selectedDate;
  final double sliderValue;
  final String savingFrequency;
  final String fundingSource;
  final String fundingSourceId;
  final bool isLoadingSavingsReturn;
  final SavingsReturnResponseData savingsReturn;
  final TextEditingController targetAmountController;
  final TextEditingController depositAmountController;
  final TextEditingController planNameController;
  final TextEditingController recurringAmountController;
  final TextEditingController topupController;
  final String transactionPin;
  final double durationSliderValue;
  final String durationTime;
  final bool topupSavingInputValidation;
  final bool topupSavingShowInput;
  //
  final AsyncValue<CardListResponse?> cardListResponse;
  final AsyncValue<CardInitiatePaymentResponse?> cardPaymentResponse;
  final CardVerificationResponse? cardVerifyResponse;
  final AsyncValue<AccountTopUpResponse?> topUpResponse;
  final String cardPaymentUrl;
  final String cardPaymentReference;
  final String? cardCallbackUrl;
  final DebitCardData? debitCard;
  final bool isCardSelected;
  final bool isLoading;
  final bool isLoadingCardVerify;

  const TargetSavingState({
    required this.isYesChecked,
    required this.autoSave,
    required this.isNoChecked,
    required this.selectedDate,
    required this.sliderValue,
    required this.savingFrequency,
    required this.fundingSource,
    required this.fundingSourceId,
    required this.savingsReturn,
    required this.isLoadingSavingsReturn,
    required this.targetAmountController,
    required this.depositAmountController,
    required this.planNameController,
    required this.recurringAmountController,
    required this.topupController,
    required this.transactionPin,
    required this.durationSliderValue,
    required this.durationTime,
    required this.topupSavingInputValidation,
    required this.topupSavingShowInput,
    //
    this.cardListResponse = const AsyncValue.data(null),
    this.cardPaymentResponse = const AsyncValue.data(null),
    this.cardVerifyResponse,
    this.topUpResponse = const AsyncValue.data(null),
    required this.cardPaymentUrl,
    required this.cardPaymentReference,
    required this.cardCallbackUrl,
    this.debitCard,
    this.isCardSelected = false,
    this.isLoading = false,
    this.isLoadingCardVerify = false,
  });

  TargetSavingState copyWith({
    bool? isYesChecked,
    bool? autoSave,
    bool? isNoChecked,
    DateTime? selectedDate,
    double? sliderValue,
    String? savingFrequency,
    String? fundingSource,
    String? fundingSourceId,
    SavingsReturnResponseData? savingsReturn,
    bool? isLoadingSavingsReturn,
    TextEditingController? targetAmountController,
    TextEditingController? depositAmountController,
    TextEditingController? planNameController,
    TextEditingController? recurringAmountController,
    TextEditingController? topupController,
    String? transactionPin,
    double? durationSliderValue,
    String? durationTime,
    bool? topupSavingInputValidation,
    bool? topupSavingShowInput,
    //
    AsyncValue<CardListResponse>? cardListResponse,
    AsyncValue<CardInitiatePaymentResponse>? cardPaymentResponse,
    CardVerificationResponse? cardVerifyResponse,
    AsyncValue<AccountTopUpResponse>? topUpResponse,
    String? cardPaymentUrl,
    String? cardPaymentReference,
    String? cardCallbackUrl,
    DebitCardData? debitCard,
    bool? isCardSelected,
    bool? isLoading,
    bool? isLoadingCardVerify,
  }) {
    return TargetSavingState(
      isYesChecked: isYesChecked ?? this.isYesChecked,
      autoSave: autoSave ?? this.autoSave,
      isNoChecked: isNoChecked ?? this.isNoChecked,
      selectedDate: selectedDate ?? this.selectedDate,
      sliderValue: sliderValue ?? this.sliderValue,
      savingFrequency: savingFrequency ?? this.savingFrequency,
      fundingSource: fundingSource ?? this.fundingSource,
      fundingSourceId: fundingSourceId ?? this.fundingSourceId,
      savingsReturn: savingsReturn ?? this.savingsReturn,
      isLoadingSavingsReturn:
          isLoadingSavingsReturn ?? this.isLoadingSavingsReturn,
      targetAmountController:
          targetAmountController ?? this.targetAmountController,
      depositAmountController:
          depositAmountController ?? this.depositAmountController,
      planNameController: planNameController ?? this.planNameController,
      recurringAmountController:
          recurringAmountController ?? this.recurringAmountController,
      topupController: topupController ?? this.topupController,
      transactionPin: transactionPin ?? this.transactionPin,
      durationSliderValue: durationSliderValue ?? this.durationSliderValue,
      durationTime: durationTime ?? this.durationTime,
      topupSavingInputValidation:
          topupSavingInputValidation ?? this.topupSavingInputValidation,
      topupSavingShowInput: topupSavingShowInput ?? this.topupSavingShowInput,
      //
      cardListResponse: cardListResponse ?? this.cardListResponse,
      cardPaymentResponse: cardPaymentResponse ?? this.cardPaymentResponse,
      cardVerifyResponse: cardVerifyResponse ?? this.cardVerifyResponse,
      topUpResponse: topUpResponse ?? this.topUpResponse,
      cardPaymentUrl: cardPaymentUrl ?? this.cardPaymentUrl,
      cardPaymentReference: cardPaymentReference ?? this.cardPaymentReference,
      cardCallbackUrl: cardCallbackUrl ?? this.cardCallbackUrl,
      debitCard: debitCard ?? this.debitCard,
      isCardSelected: isCardSelected ?? this.isCardSelected,
      isLoading: isLoading ?? this.isLoading,
      isLoadingCardVerify: isLoadingCardVerify ?? this.isLoadingCardVerify,
    );
  }

  @override
  List<Object?> get props => [
        isYesChecked,
        autoSave,
        isNoChecked,
        selectedDate,
        sliderValue,
        savingFrequency,
        fundingSource,
        fundingSourceId,
        savingsReturn,
        isLoadingSavingsReturn,
        targetAmountController,
        depositAmountController,
        planNameController,
        recurringAmountController,
        topupController,
        transactionPin,
        durationSliderValue,
        durationTime,
        topupSavingInputValidation,
        topupSavingShowInput,
        //
        cardListResponse,
        cardPaymentResponse,
        cardVerifyResponse,
        topUpResponse,
        cardPaymentUrl,
        cardPaymentReference,
        cardCallbackUrl,
        debitCard,
        isCardSelected,
      ];
}
