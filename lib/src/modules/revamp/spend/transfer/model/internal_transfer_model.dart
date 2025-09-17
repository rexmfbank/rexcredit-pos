import 'package:flutter/cupertino.dart';

class InternalTransferViewModel {
  final GlobalKey<FormState> transferFormKey;
  final TextEditingController transferAmountController;
  final TextEditingController accountNumberController;
  final TextEditingController narrationController;
  final bool hasActionBeenTriggered;
  final bool isSendToBeneficiary;
  final bool addNewBeneficiary;
  final bool isLoading;
  final String beneficiaryName;
  final String beneficiaryAccountNo;
  final String beneficiary;

  const InternalTransferViewModel({
    required this.transferFormKey,
    required this.transferAmountController,
    required this.accountNumberController,
    required this.narrationController,
    this.hasActionBeenTriggered = false,
    this.isLoading = false,
    this.isSendToBeneficiary = false,
    this.addNewBeneficiary = false,
    this.beneficiaryName = '',
    this.beneficiaryAccountNo = '',
    this.beneficiary = '',
  });

  InternalTransferViewModel copyWith({
    bool? isLoading,
    GlobalKey<FormState>? transferFormKey,
    TextEditingController? transferAmountController,
    TextEditingController? accountNumberController,
    TextEditingController? narrationController,
    bool? hasActionBeenTriggered,
    bool? isSendToBeneficiary,
    bool? addNewBeneficiary,
    String? beneficiaryName,
    String? beneficiary,
    String? beneficiaryAccountNo,
  }) {
    return InternalTransferViewModel(
      isLoading: isLoading ?? this.isLoading,
      transferFormKey: transferFormKey ?? this.transferFormKey,
      transferAmountController:
          transferAmountController ?? this.transferAmountController,
      accountNumberController:
          accountNumberController ?? this.accountNumberController,
      narrationController: narrationController ?? this.narrationController,
      hasActionBeenTriggered:
          hasActionBeenTriggered ?? this.hasActionBeenTriggered,
      isSendToBeneficiary: isSendToBeneficiary ?? this.isSendToBeneficiary,
      addNewBeneficiary: addNewBeneficiary ?? this.addNewBeneficiary,
      beneficiary: beneficiary ?? this.beneficiary,
      beneficiaryName: beneficiaryName ?? this.beneficiaryName,
      beneficiaryAccountNo: beneficiaryAccountNo ?? this.beneficiaryAccountNo,
    );
  }
}
