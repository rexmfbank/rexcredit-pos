import 'package:flutter/material.dart';
import 'package:rex_api/rex_api.dart';

import '../../shared/models/payment_method.dart';

class ElectricityScreenState {
  final TextEditingController billerNameController;
  final TextEditingController meterNumberController;
  final TextEditingController amountController;
  final TextEditingController meterTypeController;
  final TextEditingController searchMeterTypeController;
  final bool isBeneficiary;
  final bool isLoading;
  final bool validateMeterNoLoading;
  final Biller? selectedServiceProvider;
  final BillerProduct? selectedBillerProduct;
  final List<BillerProduct>? billerProducts;
  final String? formError;
  final PaymentMethod? selectedPaymentMethod;
  final PostBillPaymentData? postBillPaymentSuccess;
  final String? apiError;
  final ValidateBillData? validateBillData;

  const ElectricityScreenState({
    required this.billerNameController,
    required this.meterNumberController,
    required this.searchMeterTypeController,
    required this.amountController,
    required this.meterTypeController,
    required this.isBeneficiary,
    required this.isLoading,
    required this.validateMeterNoLoading,
    this.selectedServiceProvider,
    this.selectedBillerProduct,
    this.billerProducts = const [],
    this.formError,
    this.selectedPaymentMethod,
    this.postBillPaymentSuccess,
    this.apiError,
    this.validateBillData,
  });

  ElectricityScreenState copyWith({
    TextEditingController? billerNameController,
    TextEditingController? meterNumberController,
    TextEditingController? searchMeterTypeController,
    TextEditingController? amountController,
    TextEditingController? meterTypeController,
    bool? isBeneficiary,
    bool? isLoading,
    bool? validateMeterNoLoading,
    Biller? selectedServiceProvider,
    BillerProduct? selectedBillerProduct,
    List<BillerProduct>? billerProducts,
    String? formError,
    PaymentMethod? selectedPaymentMethod,
    PostBillPaymentData? postBillPaymentSuccess,
    String? apiError,
    ValidateBillData? validateBillData,
  }) {
    return ElectricityScreenState(
      billerNameController: billerNameController ?? this.billerNameController,
      meterNumberController:
          meterNumberController ?? this.meterNumberController,
      searchMeterTypeController:
          searchMeterTypeController ?? this.searchMeterTypeController,
      amountController: amountController ?? this.amountController,
      meterTypeController: meterTypeController ?? this.meterTypeController,
      isBeneficiary: isBeneficiary ?? this.isBeneficiary,
      isLoading: isLoading ?? this.isLoading,
      validateMeterNoLoading:
          validateMeterNoLoading ?? this.validateMeterNoLoading,
      selectedServiceProvider:
          selectedServiceProvider ?? this.selectedServiceProvider,
      selectedBillerProduct:
          selectedBillerProduct ?? this.selectedBillerProduct,
      billerProducts: billerProducts ?? this.billerProducts,
      formError: formError ?? this.formError,
      selectedPaymentMethod:
          selectedPaymentMethod ?? this.selectedPaymentMethod,
      postBillPaymentSuccess:
          postBillPaymentSuccess ?? this.postBillPaymentSuccess,
      apiError: apiError ?? this.apiError,
      validateBillData: validateBillData ?? this.validateBillData,
    );
  }

  factory ElectricityScreenState.initial() {
    return ElectricityScreenState(
      billerNameController: TextEditingController(),
      meterNumberController: TextEditingController(),
      searchMeterTypeController: TextEditingController(),
      amountController: TextEditingController(),
      meterTypeController: TextEditingController(),
      isBeneficiary: false,
      isLoading: false,
      validateMeterNoLoading: false,
    );
  }
}
