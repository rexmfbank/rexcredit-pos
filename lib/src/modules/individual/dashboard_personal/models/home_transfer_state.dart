import 'package:flutter/material.dart';
import 'package:rex_app/src/data/rex_api/rex_api.dart';

class HomeTransferState {
  final TextEditingController bankNameController;
  final TextEditingController accountNumberController;
  final TextEditingController amountController;
  final TextEditingController acctNameController;
  final TextEditingController narrationController;
  final TextEditingController searchController;
  final TextEditingController bankSearchController;
  final TabController? transferTabController;
  final GlobalKey<FormState> formKey;
  final String bankCode;
  final String bankName;
  final DateTime? selectedDate;
  final AccountLookUpResponse? accountInfo;
  final TransferData? transferResponse;
  final ListOfBanks? bankList;
  final List<BankData> banks;
  final String? accountNameError;
  final String textAccountName;
  final bool isLoading;
  final bool isSearching;
  final bool bankSelected;
  final bool saveBeneficiary;
  final bool sendToNewBeneficiary;
  final bool accountValidating;
  final bool validatedAccount;
  final bool isBeneficiarySelected;
  final List<BeneficiaryData> beneficiaries;
  final List<BeneficiaryData> mainBeneficiaries;
  final BeneficiaryData? selectedBeneficiary;

  HomeTransferState({
    required this.bankNameController,
    required this.accountNumberController,
    required this.amountController,
    required this.acctNameController,
    required this.narrationController,
    required this.searchController,
    required this.bankSearchController,
    required this.formKey,
    required this.selectedDate,
    required this.accountInfo,
    required this.transferResponse,
    required this.bankList,
    required this.accountNameError,
    required this.textAccountName,
    this.transferTabController,
    this.selectedBeneficiary,
    this.banks = const [],
    this.beneficiaries = const [],
    this.mainBeneficiaries = const [],
    this.bankCode = '',
    this.bankName = '',
    this.isLoading = false,
    this.isSearching = false,
    this.saveBeneficiary = false,
    this.sendToNewBeneficiary = false,
    this.bankSelected = false,
    this.accountValidating = false,
    this.validatedAccount = false,
    this.isBeneficiarySelected = false,
  });

  HomeTransferState copyWith({
    TextEditingController? bankNameController,
    TextEditingController? accountNumberController,
    TextEditingController? amountController,
    TextEditingController? acctNameController,
    TextEditingController? narrationController,
    TextEditingController? searchController,
    TextEditingController? bankSearchController,
    TabController? transferTabController,
    GlobalKey<FormState>? formKey,
    String? bankCode,
    String? bankName,
    String? accountNameError,
    String? textAccountName,
    ListOfBanks? bankList,
    DateTime? selectedDate,
    AccountLookUpResponse? accountInfo,
    TransferData? transferResponse,
    List<BankData>? banks,
    List<BeneficiaryData>? beneficiaries,
    List<BeneficiaryData>? mainBeneficiaries,
    BeneficiaryData? selectedBeneficiary,
    bool? isLoading,
    bool? isSearching,
    bool? bankSelected,
    bool? saveBeneficiary,
    bool? sendToNewBeneficiary,
    bool? accountValidating,
    bool? validatedAccount,
    bool? isBeneficiarySelected,
  }) {
    return HomeTransferState(
      transferTabController:
          transferTabController ?? this.transferTabController,
      bankNameController: bankNameController ?? this.bankNameController,
      accountNumberController:
          accountNumberController ?? this.accountNumberController,
      amountController: amountController ?? this.amountController,
      acctNameController: acctNameController ?? this.acctNameController,
      narrationController: narrationController ?? this.narrationController,
      searchController: searchController ?? this.searchController,
      bankSearchController: bankSearchController ?? this.bankSearchController,
      formKey: formKey ?? this.formKey,
      selectedDate: selectedDate ?? this.selectedDate,
      accountInfo: accountInfo ?? this.accountInfo,
      transferResponse: transferResponse ?? this.transferResponse,
      bankCode: bankCode ?? this.bankCode,
      bankName: bankName ?? this.bankName,
      accountNameError: accountNameError ?? this.accountNameError,
      textAccountName: textAccountName ?? this.textAccountName,
      bankList: bankList ?? this.bankList,
      banks: banks ?? this.banks,
      selectedBeneficiary: selectedBeneficiary ?? this.selectedBeneficiary,
      beneficiaries: beneficiaries ?? this.beneficiaries,
      mainBeneficiaries: mainBeneficiaries ?? this.mainBeneficiaries,
      isLoading: isLoading ?? this.isLoading,
      isSearching: isSearching ?? this.isSearching,
      saveBeneficiary: saveBeneficiary ?? this.saveBeneficiary,
      sendToNewBeneficiary: sendToNewBeneficiary ?? this.sendToNewBeneficiary,
      bankSelected: bankSelected ?? this.bankSelected,
      accountValidating: accountValidating ?? this.accountValidating,
      validatedAccount: validatedAccount ?? this.validatedAccount,
      isBeneficiarySelected:
          isBeneficiarySelected ?? this.isBeneficiarySelected,
    );
  }
}
