import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/revamp/utils/data/rex_api/rex_api.dart';

class BillPaymentScreenState {
  final bool isLoading;
  final bool balanceIsLoading;
  final String? error;
  final List<BillerCategory>? billerCategories;
  final List<Biller>? cableBillers;
  final BillerData? airtimeBillers;
  final BillerData? electricityBillers;
  final List<Biller>? electricBillers;
  final List<Biller>? dataBillers;
  final List<BeneficiaryData>? beneficiaries;
  final TextEditingController searchBeneficiaryController;

  const BillPaymentScreenState({
    required this.isLoading,
    required this.balanceIsLoading,
    this.error,
    this.billerCategories,
    this.electricBillers = const [],
    this.cableBillers,
    this.airtimeBillers,
    this.electricityBillers,
    this.dataBillers,
    this.beneficiaries,
    required this.searchBeneficiaryController,
  });

  BillPaymentScreenState copyWith({
    bool? isLoading,
    bool? balanceIsLoading,
    String? error,
    List<BillerCategory>? billerCategories,
    List<Biller>? cableBillers,
    BillerData? airtimeBillers,
    BillerData? electricityBillers,
    List<Biller>? electricBillers,
    List<Biller>? dataBillers,
    PostBillPaymentData? postBillPaymentSuccess,
    List<BeneficiaryData>? beneficiaries,
    TextEditingController? searchBeneficiaryController,
  }) {
    return BillPaymentScreenState(
      isLoading: isLoading ?? this.isLoading,
      balanceIsLoading: balanceIsLoading ?? this.balanceIsLoading,
      searchBeneficiaryController:
          searchBeneficiaryController ?? this.searchBeneficiaryController,
      error: error ?? this.error,
      billerCategories: billerCategories ?? this.billerCategories,
      cableBillers: cableBillers ?? this.cableBillers,
      electricBillers: electricBillers ?? this.electricBillers,
      airtimeBillers: airtimeBillers ?? this.airtimeBillers,
      electricityBillers: electricityBillers ?? this.electricityBillers,
      dataBillers: dataBillers ?? this.dataBillers,
      beneficiaries: beneficiaries ?? this.beneficiaries,
    );
  }

  factory BillPaymentScreenState.initial() {
    return BillPaymentScreenState(
      isLoading: false,
      balanceIsLoading: false,
      searchBeneficiaryController: TextEditingController(),
    );
  }
}
