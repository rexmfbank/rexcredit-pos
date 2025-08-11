import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/revamp/utils/data/rex_api/rex_api.dart';

class BillPaymentScreenState {
  final TextEditingController electricitySearchController;
  final TextEditingController searchBeneficiaryController;
  final TabController? airtimeTabController;
  final TabController? dataTabController;
  final TabController? electricityTabController;
  final TabController? cableTabController;
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

  const BillPaymentScreenState({
    required this.isLoading,
    required this.balanceIsLoading,
    required this.electricitySearchController,
    required this.searchBeneficiaryController,
    required this.airtimeTabController,
    required this.dataTabController,
    required this.electricityTabController,
    required this.cableTabController,
    this.error,
    this.billerCategories,
    this.electricBillers = const [],
    this.cableBillers,
    this.airtimeBillers,
    this.electricityBillers,
    this.dataBillers,
    this.beneficiaries,
  });

  BillPaymentScreenState copyWith({
    bool? isLoading,
    bool? balanceIsLoading,
    TextEditingController? electricitySearchController,
    TextEditingController? searchBeneficiaryController,
    TabController? airtimeTabController,
    TabController? dataTabController,
    TabController? electricityTabController,
    TabController? cableTabController,
    String? error,
    List<BillerCategory>? billerCategories,
    List<Biller>? cableBillers,
    BillerData? airtimeBillers,
    BillerData? electricityBillers,
    List<Biller>? electricBillers,
    List<Biller>? dataBillers,
    PostBillPaymentData? postBillPaymentSuccess,
    List<BeneficiaryData>? beneficiaries,
  }) {
    return BillPaymentScreenState(
      isLoading: isLoading ?? this.isLoading,
      balanceIsLoading: balanceIsLoading ?? this.balanceIsLoading,
      electricitySearchController:
          electricitySearchController ?? this.electricitySearchController,
      searchBeneficiaryController:
          searchBeneficiaryController ?? this.searchBeneficiaryController,
      airtimeTabController: airtimeTabController ?? this.airtimeTabController,
      dataTabController: dataTabController ?? this.dataTabController,
      cableTabController: cableTabController ?? this.cableTabController,
      electricityTabController:
          electricityTabController ?? this.electricityTabController,
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
      electricitySearchController: TextEditingController(),
      searchBeneficiaryController: TextEditingController(),
      airtimeTabController: null,
      dataTabController: null,
      cableTabController: null,
      electricityTabController: null,
    );
  }
}
