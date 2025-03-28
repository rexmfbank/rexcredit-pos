import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_api/rex_api.dart';

class DashboardTopUpState extends Equatable {
  final TextEditingController amountController;
  final AsyncValue<CardListResponse?> cardListResponse;
  final AsyncValue<CardInitiatePaymentResponse?> cardPaymentResponse;
  final CardVerificationResponse? cardVerifyResponse;
  final AccountTopUpResponse topUpResponse;
  final String cardPaymentUrl;
  final String cardPaymentReference;
  final String? cardCallbackUrl;
  final DebitCardData? debitCard;
  final bool isCardSelected;
  final bool isLoading;
  final bool isLoadingCardVerify;

  const DashboardTopUpState({
    required this.amountController,
    this.cardListResponse = const AsyncValue.data(null),
    this.cardPaymentResponse = const AsyncValue.data(null),
    this.cardVerifyResponse,
    this.topUpResponse = const AccountTopUpResponse.empty(),
    required this.cardPaymentUrl,
    required this.cardPaymentReference,
    required this.cardCallbackUrl,
    this.debitCard,
    this.isCardSelected = false,
    this.isLoading = false,
    this.isLoadingCardVerify = false,
  });

  DashboardTopUpState copyWith({
    TextEditingController? amountController,
    AsyncValue<CardListResponse>? cardListResponse,
    AsyncValue<CardInitiatePaymentResponse>? cardPaymentResponse,
    CardVerificationResponse? cardVerifyResponse,
    AccountTopUpResponse? topUpResponse,
    String? cardPaymentUrl,
    String? cardPaymentReference,
    String? cardCallbackUrl,
    DebitCardData? debitCard,
    bool? isCardSelected,
    bool? isLoading,
    bool? isLoadingCardVerify,
  }) {
    return DashboardTopUpState(
      amountController: amountController ?? this.amountController,
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
  String toString() => {
        "CLASS": "DashboardTopUpState",
        "amountControllerText": amountController.text,
        "cardPaymentUrl": cardPaymentUrl,
        "cardPaymentReference": cardPaymentReference,
        "cardCallbackUrl": cardCallbackUrl,
        "debitCard": debitCard,
        "isCardSelected": isCardSelected,
      }.toString();

  @override
  List<Object?> get props => [
        amountController,
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
