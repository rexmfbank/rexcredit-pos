import 'package:flutter/cupertino.dart';
import 'package:rex_app/src/modules/revamp/utils/data/rex_api/rex_api.dart';

import '../../shared/models/payment_method.dart';

class CableScreenState {
  final TextEditingController smartCardNumberController;
  final TextEditingController amountController;
  final TextEditingController bouquetPlanController;
  final TextEditingController cableSearchController;
  final bool isBeneficiary;
  final bool isLoading;
  final bool validateSmartCardNoLoading;
  final Biller? selectedServiceProvider;
  final List<BillerProduct>? cableBillers;
  final BillerProduct? selectedBouquetPlan;
  final String? formError;
  final PaymentMethod? selectedPaymentMethod;
  final PostBillPaymentData? postBillPaymentSuccess;
  final String? apiError;
  final ValidateBillData? validateBillData;

  const CableScreenState({
    required this.smartCardNumberController,
    required this.amountController,
    required this.bouquetPlanController,
    required this.cableSearchController,
    required this.isBeneficiary,
    required this.isLoading,
    required this.validateSmartCardNoLoading,
    this.cableBillers = const [],
    this.selectedServiceProvider,
    this.selectedBouquetPlan,
    this.formError,
    this.selectedPaymentMethod,
    this.postBillPaymentSuccess,
    this.apiError,
    this.validateBillData,
  });

  CableScreenState copyWith({
    TextEditingController? smartCardNumberController,
    TextEditingController? amountController,
    TextEditingController? bouquetPlanController,
    TextEditingController? cableSearchController,
    Biller? selectedServiceProvider,
    List<BillerProduct>? cableBillers,
    BillerProduct? selectedBouquetPlan,
    String? formError,
    PaymentMethod? selectedPaymentMethod,
    bool? isBeneficiary,
    bool? isLoading,
    bool? validateSmartCardNoLoading,
    PostBillPaymentData? postBillPaymentSuccess,
    String? apiError,
    ValidateBillData? validateBillData,
  }) {
    return CableScreenState(
      smartCardNumberController:
          smartCardNumberController ?? this.smartCardNumberController,
      amountController: amountController ?? this.amountController,
      bouquetPlanController:
          bouquetPlanController ?? this.bouquetPlanController,
      cableSearchController:
          cableSearchController ?? this.cableSearchController,
      selectedServiceProvider:
          selectedServiceProvider ?? this.selectedServiceProvider,
      selectedBouquetPlan: selectedBouquetPlan ?? this.selectedBouquetPlan,
      cableBillers: cableBillers ?? this.cableBillers,
      formError: formError ?? this.formError,
      selectedPaymentMethod:
          selectedPaymentMethod ?? this.selectedPaymentMethod,
      isBeneficiary: isBeneficiary ?? this.isBeneficiary,
      isLoading: isLoading ?? this.isLoading,
      validateSmartCardNoLoading:
          validateSmartCardNoLoading ?? this.validateSmartCardNoLoading,
      postBillPaymentSuccess:
          postBillPaymentSuccess ?? this.postBillPaymentSuccess,
      apiError: apiError ?? this.apiError,
      validateBillData: validateBillData ?? this.validateBillData,
    );
  }

  factory CableScreenState.initial() {
    return CableScreenState(
      smartCardNumberController: TextEditingController(),
      amountController: TextEditingController(),
      bouquetPlanController: TextEditingController(),
      cableSearchController: TextEditingController(),
      isBeneficiary: false,
      isLoading: false,
      validateSmartCardNoLoading: false,
    );
  }
}
