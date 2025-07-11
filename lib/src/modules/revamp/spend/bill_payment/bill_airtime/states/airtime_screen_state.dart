import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:rex_app/src/modules/revamp/utils/data/rex_api/rex_api.dart';
import 'package:rex_app/src/modules/revamp/spend/bill_payment/shared/models/payment_method.dart';

import '../../../../../../utils/date_utils/change_date_format.dart';

class AirtimeScreenState {
  final TextEditingController phoneNumberController;
  final TextEditingController amountController;
  final bool isBeneficiary;
  final bool isLoading;
  final Biller? selectedServiceProvider;
  final String? formError;
  final PaymentMethod? selectedPaymentMethod;
  final PostBillPaymentData? postBillPaymentSuccess;
  final String? apiError;
  final PagingController<int, TransferData> historyPagingController;
  final String? startDate;
  final String? endDate;

  const AirtimeScreenState({
    required this.phoneNumberController,
    required this.amountController,
    required this.isBeneficiary,
    required this.isLoading,
    this.selectedServiceProvider,
    this.formError,
    this.selectedPaymentMethod,
    this.postBillPaymentSuccess,
    this.apiError,
    required this.historyPagingController,
    this.startDate,
    this.endDate,
  });

  AirtimeScreenState copyWith({
    TextEditingController? phoneNumberController,
    TextEditingController? amountController,
    TextEditingController? narrationController,
    Biller? selectedServiceProvider,
    String? formError,
    PaymentMethod? selectedPaymentMethod,
    bool? isBeneficiary,
    bool? isLoading,
    PostBillPaymentData? postBillPaymentSuccess,
    String? apiError,
    PagingController<int, TransferData>? historyPagingController,
    String? startDate,
    String? endDate,
  }) {
    return AirtimeScreenState(
      phoneNumberController:
          phoneNumberController ?? this.phoneNumberController,
      amountController: amountController ?? this.amountController,
      selectedServiceProvider:
          selectedServiceProvider ?? this.selectedServiceProvider,
      formError: formError ?? this.formError,
      selectedPaymentMethod:
          selectedPaymentMethod ?? this.selectedPaymentMethod,
      isBeneficiary: isBeneficiary ?? this.isBeneficiary,
      isLoading: isLoading ?? this.isLoading,
      postBillPaymentSuccess:
          postBillPaymentSuccess ?? this.postBillPaymentSuccess,
      apiError: apiError ?? this.apiError,
      historyPagingController:
          historyPagingController ?? this.historyPagingController,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
    );
  }

  factory AirtimeScreenState.initial() {
    return AirtimeScreenState(
      phoneNumberController: TextEditingController(),
      amountController: TextEditingController(),
      isBeneficiary: false,
      isLoading: false,
      historyPagingController: PagingController(firstPageKey: 0),
      startDate: convertDateTimeToyyyymmddFormat(DateTime.now()),
      endDate: convertDateTimeToyyyymmddFormat(DateTime.now()),
    );
  }
}
