import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/api/rex_api.dart';

class TransferExtState extends Equatable {
  final TextEditingController bankNameController;
  final TextEditingController accountNumberController;
  final TextEditingController amountController;
  final TextEditingController acctNameController;
  final TextEditingController narrationController;
  final TextEditingController searchController;
  final TextEditingController bankSearchController;
  final TabController? transferTabController;
  final bool isLoading;
  final bool fetchingBanks;
  final bool bankSelected;
  final String recipientCode;
  final String recipientAcctNo;
  final String recipientAcctName;
  final String recipientBankCode;
  final String recipientBankName;
  final List<BankData> banksList;

  const TransferExtState({
    required this.bankNameController,
    required this.accountNumberController,
    required this.amountController,
    required this.acctNameController,
    required this.narrationController,
    required this.searchController,
    required this.bankSearchController,
    this.transferTabController,
    required this.isLoading,
    required this.fetchingBanks,
    required this.bankSelected,
    required this.recipientAcctName,
    required this.recipientAcctNo,
    required this.recipientBankCode,
    required this.recipientBankName,
    required this.recipientCode,
    required this.banksList,
  });

  TransferExtState copyWith({
    TextEditingController? bankNameController,
    TextEditingController? accountNumberController,
    TextEditingController? amountController,
    TextEditingController? acctNameController,
    TextEditingController? narrationController,
    TextEditingController? searchController,
    TextEditingController? bankSearchController,
    TabController? transferTabController,
    bool? isLoading,
    bool? fetchingBanks,
    bool? bankSelected,
    String? recipientAcctName,
    String? recipientAcctNo,
    String? recipientBankCode,
    String? recipientBankName,
    String? recipientCode,
    List<BankData>? banksList,
  }) => TransferExtState(
    bankNameController: bankNameController ?? this.bankNameController,
    accountNumberController:
        accountNumberController ?? this.accountNumberController,
    amountController: amountController ?? this.amountController,
    acctNameController: acctNameController ?? this.acctNameController,
    narrationController: narrationController ?? this.narrationController,
    searchController: searchController ?? this.searchController,
    bankSearchController: bankSearchController ?? this.bankSearchController,
    transferTabController: transferTabController ?? this.transferTabController,
    isLoading: isLoading ?? this.isLoading,
    fetchingBanks: fetchingBanks ?? this.fetchingBanks,
    bankSelected: bankSelected ?? this.bankSelected,
    recipientAcctName: recipientAcctName ?? this.recipientAcctName,
    recipientAcctNo: recipientAcctNo ?? this.recipientAcctNo,
    recipientBankCode: recipientBankCode ?? this.recipientBankCode,
    recipientBankName: recipientBankName ?? this.recipientBankName,
    recipientCode: recipientCode ?? this.recipientCode,
    banksList: banksList ?? this.banksList,
  );

  @override
  List<Object?> get props => [
    bankNameController,
    accountNumberController,
    amountController,
    acctNameController,
    narrationController,
    searchController,
    bankSearchController,
    transferTabController,
    isLoading,
    fetchingBanks,
    bankSelected,
    recipientAcctName,
    recipientAcctNo,
    recipientBankCode,
    recipientBankName,
    recipientCode,
    banksList,
  ];
}
