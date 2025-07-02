import 'package:flutter/cupertino.dart';
import 'package:rex_app/src/modules/revamp/utils/data/rex_api/rex_api.dart';

import '../../shared/models/payment_method.dart';

class DataScreenState {
  final TextEditingController phoneNumberController;
  final TextEditingController amountController;
  final TextEditingController dataPlanController;
  final TextEditingController dataSearchController;
  final bool isBeneficiary;
  final bool isLoading;
  final Biller? selectedServiceProvider;
  final BillerProduct? selectedDataPlan;
  final List<BillerProduct>? products;
  final String? formError;
  final PaymentMethod? selectedPaymentMethod;
  final PostBillPaymentData? postBillPaymentSuccess;
  final String? apiError;

  const DataScreenState({
    required this.phoneNumberController,
    required this.amountController,
    required this.dataPlanController,
    required this.dataSearchController,
    required this.isBeneficiary,
    required this.isLoading,
    this.products = const [],
    this.selectedServiceProvider,
    this.selectedDataPlan,
    this.formError,
    this.selectedPaymentMethod,
    this.postBillPaymentSuccess,
    this.apiError,
  });

  DataScreenState copyWith({
    TextEditingController? phoneNumberController,
    TextEditingController? amountController,
    TextEditingController? dataPlanController,
    TextEditingController? dataSearchController,
    Biller? selectedServiceProvider,
    List<BillerProduct>? products,
    BillerProduct? selectedDataPlan,
    String? formError,
    PaymentMethod? selectedPaymentMethod,
    bool? isBeneficiary,
    bool? isLoading,
    PostBillPaymentData? postBillPaymentSuccess,
    String? apiError,
  }) {
    return DataScreenState(
      phoneNumberController:
          phoneNumberController ?? this.phoneNumberController,
      amountController: amountController ?? this.amountController,
      dataPlanController: dataPlanController ?? this.dataPlanController,
      dataSearchController: dataSearchController ?? this.dataSearchController,
      selectedServiceProvider:
          selectedServiceProvider ?? this.selectedServiceProvider,
      selectedDataPlan: selectedDataPlan ?? this.selectedDataPlan,
      products: products ?? this.products,
      formError: formError ?? this.formError,
      selectedPaymentMethod:
          selectedPaymentMethod ?? this.selectedPaymentMethod,
      isBeneficiary: isBeneficiary ?? this.isBeneficiary,
      isLoading: isLoading ?? this.isLoading,
      postBillPaymentSuccess:
          postBillPaymentSuccess ?? this.postBillPaymentSuccess,
      apiError: apiError ?? this.apiError,
    );
  }

  factory DataScreenState.initial() {
    return DataScreenState(
      phoneNumberController: TextEditingController(),
      amountController: TextEditingController(),
      dataPlanController: TextEditingController(),
      dataSearchController: TextEditingController(),
      isBeneficiary: false,
      isLoading: false,
    );
  }
}
