import 'package:flutter/widgets.dart';

class RequestPOSScreenState {
  final bool isLoading;
  final String? error;
  final dynamic requestPosResponse;
  final TextEditingController contactPersonController;
  final TextEditingController ninController;
  final TextEditingController lineOfBusinessController;
  final TextEditingController settlementAccountNameController;
  final TextEditingController settlementAccountNumberController;
  final TextEditingController settlementBankNameController;
  final TextEditingController emailAddressController;
  final TextEditingController phoneNumberController;
  final TextEditingController physicalAddressController;
  final TextEditingController bvnController;
  final String bvn;
  final GlobalKey<FormState> formKey;

  const RequestPOSScreenState(
      {required this.isLoading,
      this.error,
      this.requestPosResponse,
      required this.physicalAddressController,
      required this.bvn,
      required this.contactPersonController,
      required this.ninController,
      required this.lineOfBusinessController,
      required this.settlementAccountNameController,
      required this.settlementAccountNumberController,
      required this.settlementBankNameController,
      required this.emailAddressController,
      required this.phoneNumberController,
      required this.bvnController,
      required this.formKey});

  RequestPOSScreenState copyWith({
    bool? isLoading,
    String? error,
    dynamic requestPosResponse,
    TextEditingController? physicalAddressController,
    TextEditingController? contactPersonController,
    TextEditingController? ninController,
    TextEditingController? lineOfBusinessController,
    TextEditingController? settlementAccountNameController,
    TextEditingController? settlementAccountNumberController,
    TextEditingController? settlementBankNameController,
    TextEditingController? emailAddressController,
    TextEditingController? phoneNumberController,
    TextEditingController? bvnController,
    String? selectedEmail,
    String? bvn,
    GlobalKey<FormState>? formKey,
  }) {
    return RequestPOSScreenState(
        isLoading: isLoading ?? this.isLoading,
        error: error ?? this.error,
        requestPosResponse: requestPosResponse ?? this.requestPosResponse,
        physicalAddressController:
            physicalAddressController ?? this.physicalAddressController,
        contactPersonController:
            contactPersonController ?? this.contactPersonController,
        ninController: ninController ?? this.ninController,
        lineOfBusinessController:
            lineOfBusinessController ?? this.lineOfBusinessController,
        settlementAccountNameController: settlementAccountNameController ??
            this.settlementAccountNameController,
        settlementAccountNumberController: settlementAccountNumberController ??
            this.settlementAccountNumberController,
        settlementBankNameController:
            settlementBankNameController ?? this.settlementBankNameController,
        emailAddressController:
            emailAddressController ?? this.emailAddressController,
        phoneNumberController:
            phoneNumberController ?? this.phoneNumberController,
        bvnController: bvnController ?? this.bvnController,
        bvn: bvn ?? this.bvn,
        formKey: formKey ?? this.formKey);
  }

  factory RequestPOSScreenState.initial() {
    return RequestPOSScreenState(
        isLoading: false,
        physicalAddressController: TextEditingController(),
        contactPersonController: TextEditingController(),
        ninController: TextEditingController(),
        lineOfBusinessController: TextEditingController(),
        settlementAccountNameController: TextEditingController(),
        settlementAccountNumberController: TextEditingController(),
        settlementBankNameController: TextEditingController(),
        emailAddressController: TextEditingController(),
        phoneNumberController: TextEditingController(),
        bvnController: TextEditingController(),
        bvn: '',
        formKey: GlobalKey<FormState>());
  }
}
