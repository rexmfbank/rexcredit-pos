import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/data/rex_api/rex_api.dart';

class FixedDepositState extends Equatable {
  final String? fundingSource;
  final String? fundingSourceId;
  final TextEditingController planNameController;
  final TextEditingController amountController;
  final DepositInterestTypeData depositInterestTypeData;
  final bool isLoadingSavingsReturn;
  final DepositInterestRateData depositInterestRateData;
  final double durationSliderValue;
  final String durationTime;
  final String transactionPin;
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

  const FixedDepositState({
    required this.fundingSource,
    required this.fundingSourceId,
    required this.planNameController,
    required this.amountController,
    required this.depositInterestTypeData,
    required this.isLoadingSavingsReturn,
    required this.depositInterestRateData,
    required this.durationSliderValue,
    required this.durationTime,
    required this.transactionPin,
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

  FixedDepositState copyWith({
    String? fundingSource,
    String? fundingSourceId,
    TextEditingController? planNameController,
    TextEditingController? amountController,
    DepositInterestTypeData? depositInterestTypeData,
    bool? isLoadingSavingsReturn,
    DepositInterestRateData? depositInterestRateData,
    double? durationSliderValue,
    String? durationTime,
    String? transactionPin,
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
    return FixedDepositState(
      fundingSource: fundingSource ?? this.fundingSource,
      fundingSourceId: fundingSourceId ?? this.fundingSourceId,
      planNameController: planNameController ?? this.planNameController,
      amountController: amountController ?? this.amountController,
      depositInterestTypeData:
          depositInterestTypeData ?? this.depositInterestTypeData,
      isLoadingSavingsReturn:
          isLoadingSavingsReturn ?? this.isLoadingSavingsReturn,
      depositInterestRateData:
          depositInterestRateData ?? this.depositInterestRateData,
      durationSliderValue: durationSliderValue ?? this.durationSliderValue,
      durationTime: durationTime ?? this.durationTime,
      transactionPin: transactionPin ?? this.transactionPin,
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
  List<Object?> get props => [];
}
