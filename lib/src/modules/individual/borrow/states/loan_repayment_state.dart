import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class LoanRepaymentState extends Equatable {
  final TextEditingController amountController;
  final String fundingSource;
  final String fundingSourceId;
  final bool terminateLoan;

  const LoanRepaymentState({
    required this.amountController,
    required this.fundingSource,
    required this.fundingSourceId,
    required this.terminateLoan,
  });

  LoanRepaymentState copyWith({
    TextEditingController? amountController,
    String? fundingSource,
    String? fundingSourceId,
    bool? terminateLoan,
  }) {
    return LoanRepaymentState(
      amountController: amountController ?? this.amountController,
      fundingSource: fundingSource ?? this.fundingSource,
      fundingSourceId: fundingSourceId ?? this.fundingSourceId,
      terminateLoan: terminateLoan ?? this.terminateLoan,
    );
  }

  @override
  List<Object?> get props => [
        amountController,
        fundingSource,
        fundingSourceId,
        terminateLoan,
      ];
}
