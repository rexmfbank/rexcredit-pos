import 'package:flutter/widgets.dart';
import 'package:rex_api/rex_api.dart';

class IndividualLoanCalculationScreenState {
  final bool isLoading;
  final String? error;
  final TextEditingController loanAmountController;
  final FocusNode loanAmountFocusNode;
  final ComputeLoanResponseData? computedLoan;
  final String selectedTenor;
  final String? monthlyRepaymentAmount;
  final String? totalRepaymentAmount;
  final String? loanPurpose;

  const IndividualLoanCalculationScreenState(
      {required this.isLoading,
      this.error,
      required this.loanAmountController,
      required this.loanAmountFocusNode,
      this.computedLoan,
      required this.selectedTenor,
      this.monthlyRepaymentAmount,
      this.totalRepaymentAmount,
      this.loanPurpose});

  IndividualLoanCalculationScreenState copyWith(
      {bool? isLoading,
      String? error,
      TextEditingController? loanAmountController,
      FocusNode? loanAmountFocusNode,
      ComputeLoanResponseData? computedLoan,
      String? selectedTenor,
      String? monthlyRepaymentAmount,
      String? totalRepaymentAmount,
      String? loanPurpose}) {
    return IndividualLoanCalculationScreenState(
        isLoading: isLoading ?? this.isLoading,
        error: error ?? this.error,
        loanAmountController: loanAmountController ?? this.loanAmountController,
        loanAmountFocusNode: loanAmountFocusNode ?? this.loanAmountFocusNode,
        computedLoan: computedLoan ?? this.computedLoan,
        selectedTenor: selectedTenor ?? this.selectedTenor,
        monthlyRepaymentAmount:
            monthlyRepaymentAmount ?? this.monthlyRepaymentAmount,
        totalRepaymentAmount: totalRepaymentAmount ?? this.totalRepaymentAmount,
        loanPurpose: loanPurpose ?? this.loanPurpose);
  }

  factory IndividualLoanCalculationScreenState.initial() {
    return IndividualLoanCalculationScreenState(
      isLoading: false,
      loanAmountController: TextEditingController(),
      selectedTenor: "1",
      loanAmountFocusNode: FocusNode(),
    );
  }
}
