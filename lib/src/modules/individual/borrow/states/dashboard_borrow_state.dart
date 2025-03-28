import 'package:rex_api/rex_api.dart';

class DashboardBorrowScreenState {
  final bool isLoading;
  final String? error;
  final LoanProductModel? selectedLoanProduct;
  final List<LoanProductModel>? loanProducts;
  final List<LoanApplicationResponseData>? loanApplications;
  final LoanApplicationResponseData? loanApplication;
  final List<String>? loanPurposeOptions;

  const DashboardBorrowScreenState(
      {required this.isLoading,
      this.error,
      this.selectedLoanProduct,
      this.loanProducts,
      this.loanApplication,
      this.loanApplications,
      this.loanPurposeOptions});

  DashboardBorrowScreenState copyWith({
    bool? isLoading,
    String? error,
    LoanProductModel? selectedLoanProduct,
    List<LoanProductModel>? loanProducts,
    LoanApplicationResponseData? loanApplication,
    List<LoanApplicationResponseData>? loanApplications,
    List<String>? loanPurposeOptions,
  }) {
    return DashboardBorrowScreenState(
        isLoading: isLoading ?? this.isLoading,
        error: error ?? this.error,
        selectedLoanProduct: selectedLoanProduct ?? this.selectedLoanProduct,
        loanProducts: loanProducts ?? this.loanProducts,
        loanApplication: loanApplication ?? this.loanApplication,
        loanApplications: loanApplications ?? this.loanApplications,
        loanPurposeOptions: loanPurposeOptions ?? this.loanPurposeOptions);
  }

  factory DashboardBorrowScreenState.initial() {
    return const DashboardBorrowScreenState(
      isLoading: false,
    );
  }
}
