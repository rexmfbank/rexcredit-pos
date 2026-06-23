import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class TransferIntState extends Equatable {
  final TextEditingController amountController;
  final TextEditingController accountNumberController;
  final TextEditingController narrationController;
  final bool isLoading;
  final String recipientCode;
  final String recipientAcctNo;
  final String recipientAcctName;
  final String recipientBankCode;
  final String recipientBankName;

  const TransferIntState({
    required this.amountController,
    required this.accountNumberController,
    required this.narrationController,
    required this.isLoading,
    required this.recipientCode,
    required this.recipientAcctNo,
    required this.recipientAcctName,
    required this.recipientBankCode,
    required this.recipientBankName,
  });

  TransferIntState copyWith({
    TextEditingController? amountController,
    TextEditingController? accountNumberController,
    TextEditingController? narrationController,
    bool? isLoading,
    String? recipientCode,
    String? recipientAcctNo,
    String? recipientAcctName,
    String? recipientBankCode,
    String? recipientBankName,
  }) {
    return TransferIntState(
      amountController: amountController ?? this.amountController,
      accountNumberController:
          accountNumberController ?? this.accountNumberController,
      narrationController: narrationController ?? this.narrationController,
      isLoading: isLoading ?? this.isLoading,
      recipientCode: recipientCode ?? this.recipientCode,
      recipientAcctName: recipientAcctName ?? this.recipientAcctName,
      recipientAcctNo: recipientAcctNo ?? this.recipientAcctNo,
      recipientBankCode: recipientBankCode ?? this.recipientBankCode,
      recipientBankName: recipientBankName ?? this.recipientBankName,
    );
  }

  @override
  List<Object?> get props => [
    amountController,
    accountNumberController,
    narrationController,
    isLoading,
    recipientCode,
    recipientAcctName,
    recipientAcctNo,
    recipientBankCode,
    recipientBankName,
  ];
}
