import 'package:rex_api/rex_api.dart';

class IndividualLoanManagementScreenState {
  final bool isLoading;
  final String? error;
  final LoanDetail? loanDetail;

  const IndividualLoanManagementScreenState({
    required this.isLoading,
    this.error,
    this.loanDetail,
  });

  IndividualLoanManagementScreenState copyWith({
    bool? isLoading,
    String? error,
    LoanDetail? loanDetail,
  }) {
    return IndividualLoanManagementScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      loanDetail: loanDetail ?? this.loanDetail,
    );
  }

  factory IndividualLoanManagementScreenState.initial() {
    return const IndividualLoanManagementScreenState(
      isLoading: false,
    );
  }
}
