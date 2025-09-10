import 'package:rex_app/src/modules/revamp/data/rex_api/rex_api.dart';
import 'package:rex_app/src/modules/revamp/spend/provider_bills/payment_method.dart';

import '../../../../utils/date_utils/change_date_format.dart';

class AirtimeScreenState {
  final bool isBeneficiary;
  final bool isLoading;
  final Biller? selectedServiceProvider;
  final String? formError;
  final PaymentMethod? selectedPaymentMethod;
  final PostBillPaymentData? postBillPaymentSuccess;
  final String? apiError;
  final String? startDate;
  final String? endDate;

  const AirtimeScreenState({
    required this.isBeneficiary,
    required this.isLoading,
    this.selectedServiceProvider,
    this.formError,
    this.selectedPaymentMethod,
    this.postBillPaymentSuccess,
    this.apiError,
    this.startDate,
    this.endDate,
  });

  AirtimeScreenState copyWith({
    Biller? selectedServiceProvider,
    String? formError,
    PaymentMethod? selectedPaymentMethod,
    bool? isBeneficiary,
    bool? isLoading,
    PostBillPaymentData? postBillPaymentSuccess,
    String? apiError,

    String? startDate,
    String? endDate,
  }) {
    return AirtimeScreenState(
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

      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
    );
  }

  factory AirtimeScreenState.initial() {
    return AirtimeScreenState(
      isBeneficiary: false,
      isLoading: false,
      startDate: convertDateTimeToyyyymmddFormat(DateTime.now()),
      endDate: convertDateTimeToyyyymmddFormat(DateTime.now()),
    );
  }
}
