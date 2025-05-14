// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/data/rex_api/rex_api.dart';
import 'package:rex_app/src/config/routes/route_name.dart';
import 'package:rex_app/src/modules/shared/onboarding/onboard_business/common/model/business_file_enum.dart';
import 'package:rex_app/src/modules/shared/onboarding/onboard_business/business_cooperative/model/cooperative_doc_state.dart';
import 'package:rex_app/src/modules/shared/onboarding/set_transaction_pin/provider/set_transaction_pin_provider.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/loading_screen.dart';
import 'package:rex_app/src/modules/shared/widgets/modal_bottom_sheets/show_modal_action.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

final cooperativeDocProvider =
    NotifierProvider<CooperativeDocNotifier, CooperativeDocState>(
  () => CooperativeDocNotifier(),
);

class CooperativeDocNotifier extends Notifier<CooperativeDocState> {
  @override
  CooperativeDocState build() {
    return const CooperativeDocState(
      utilityBill: BusinessFileStatus.fileIsNull,
      registerCert: BusinessFileStatus.fileIsNull,
      resAccount: BusinessFileStatus.fileIsNull,
      constitution: BusinessFileStatus.fileIsNull,
      businessDocs: [],
      utilityBillFile: null,
      utilityBillFileName: '',
      utilityBillDocName: '',
      utilityBillDocPath: '',
      registerCertFile: null,
      registerCertFileName: '',
      registerCertDocName: '',
      registerCertDocPath: '',
      resAccountFile: null,
      resAccountFileName: '',
      resAccountDocName: '',
      resAccountDocPath: '',
      constitutionFile: null,
      constitutionFileName: '',
      constitutionDocName: '',
      constitutionDocPath: '',
    );
  }

  Future<void> getFileFromDevice({
    required BusinessFileEnum docType,
  }) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      File file = File(result.files.single.path!);
      if (docType == BusinessFileEnum.UTILITY_BILL) {
        state = state.copyWith(utilityBillFile: file);
        uploadUtilityBillToServer();
      } else if (docType == BusinessFileEnum.CERTIFICATE_OF_REGISTRATION) {
        state = state.copyWith(registerCertFile: file);
        uploadRegisterCertToServer();
      } else if (docType == BusinessFileEnum.RESOLUTION_ACCOUNT_OPENING) {
        state = state.copyWith(resAccountFile: file);
        uploadResAccountToServer();
      } else if (docType == BusinessFileEnum.COPY_OF_CONSTITUTION) {
        state = state.copyWith(constitutionFile: file);
        uploadConstitutionToServer();
      }
    }
  }

  Future<void> uploadUtilityBillToServer() async {
    String fileName = File(state.utilityBillFile!.path).uri.pathSegments.last;
    state = state.copyWith(utilityBillFileName: fileName);
    state = state.copyWith(utilityBill: BusinessFileStatus.fileIsNotNull);
    try {
      state = state.copyWith(utilityBill: BusinessFileStatus.fileIsUploading);
      final uploadResponse = await RexApi.instance.uploadFile(
        filePath: state.utilityBillFile!.path,
        fileName: fileName,
      );
      state = state.copyWith(
        utilityBill: BusinessFileStatus.fileIsUploaded,
        utilityBillDocName: uploadResponse.data?.id,
        utilityBillDocPath: uploadResponse.data?.refNo,
      );
    } catch (error) {
      state = state.copyWith(
        utilityBill: BusinessFileStatus.fileUploadError,
        utilityBillFile: null,
        utilityBillDocName: '',
        utilityBillDocPath: '',
      );
    }
  }

  Future<void> uploadRegisterCertToServer() async {
    String fileName = File(state.registerCertFile!.path).uri.pathSegments.last;
    state = state.copyWith(registerCertFileName: fileName);
    state = state.copyWith(registerCert: BusinessFileStatus.fileIsNotNull);
    try {
      state = state.copyWith(registerCert: BusinessFileStatus.fileIsUploading);
      final uploadResponse = await RexApi.instance.uploadFile(
        filePath: state.registerCertFile!.path,
        fileName: fileName,
      );
      state = state.copyWith(
        registerCert: BusinessFileStatus.fileIsUploaded,
        registerCertDocName: uploadResponse.data?.id,
        registerCertDocPath: uploadResponse.data?.refNo,
      );
    } catch (error) {
      state = state.copyWith(
        registerCert: BusinessFileStatus.fileUploadError,
        registerCertFile: null,
        registerCertDocName: '',
        registerCertDocPath: '',
      );
    }
  }

  Future<void> uploadResAccountToServer() async {
    String fileName = File(state.resAccountFile!.path).uri.pathSegments.last;
    state = state.copyWith(resAccountFileName: fileName);
    state = state.copyWith(resAccount: BusinessFileStatus.fileIsNotNull);
    try {
      state = state.copyWith(resAccount: BusinessFileStatus.fileIsUploading);
      final uploadResponse = await RexApi.instance.uploadFile(
        filePath: state.resAccountFile!.path,
        fileName: fileName,
      );
      state = state.copyWith(
        resAccount: BusinessFileStatus.fileIsUploaded,
        resAccountDocName: uploadResponse.data?.id,
        resAccountDocPath: uploadResponse.data?.refNo,
      );
    } catch (error) {
      state = state.copyWith(
        resAccount: BusinessFileStatus.fileUploadError,
        resAccountFile: null,
        resAccountDocName: '',
        resAccountDocPath: '',
      );
    }
  }

  Future<void> uploadConstitutionToServer() async {
    String fileName = File(state.constitutionFile!.path).uri.pathSegments.last;
    state = state.copyWith(constitutionFileName: fileName);
    state = state.copyWith(constitution: BusinessFileStatus.fileIsNotNull);
    try {
      state = state.copyWith(constitution: BusinessFileStatus.fileIsUploading);
      final uploadResponse = await RexApi.instance.uploadFile(
        filePath: state.constitutionFile!.path,
        fileName: fileName,
      );
      state = state.copyWith(
        constitution: BusinessFileStatus.fileIsUploaded,
        constitutionDocName: uploadResponse.data?.id,
        constitutionDocPath: uploadResponse.data?.refNo,
      );
    } catch (error) {
      state = state.copyWith(
        constitution: BusinessFileStatus.fileUploadError,
        constitutionFile: null,
        constitutionDocName: '',
        constitutionDocPath: '',
      );
    }
  }

  void validateDocuments(BuildContext context) {
    if (state.registerCertFile == null ||
        state.resAccountFile == null ||
        state.utilityBillFile == null ||
        state.constitutionFile == null) {
      showModalActionError(
        context: context,
        errorText: StringAssets.emptyDocs2,
        title: StringAssets.emptyDocs1,
      );
    } else {
      _intializeDocumentsForCooperative();
      _submitDocuments(context);
    }
  }

  void _submitDocuments(BuildContext context) async {
    final username = ref.watch(usernameProvider);
    final onboardingId = ref.watch(userOnboardingIdProvider);
    final accountType = ref.watch(userAccountTypeProvider);
    //
    final request = CompleteOnboardRequest(
      onboardingId: onboardingId,
      addressDto: const AddressDto(
        houseNumber: '',
        street: '',
        area: '',
        state: '',
        city: '',
        lga: '',
        country: '',
        longitude: 0,
        latitude: 0,
      ),
      username: username,
      gender: 'male',
      customerType: 'business',
      referralCode: '',
      language: 'en',
      employmentCategory: '',
      annualIncomeRange: '',
      nationalId: '',
      documents: state.businessDocs,
      businessDetailDto: BusinessDetailDto(
        businessType: accountType,
        registrationNumber: '',
        businessRegistered: '',
        businessRegistrationLink: '',
        businessEmail: '',
        businessAddress: '',
        taxNumber: '',
        mobileNumber: '',
        businessName: '',
        yearsInBusiness: 0,
        businessSector: '',
        businessLogo: '',
        directorInfoList: [],
      ),
    );
    //
    LoadingScreen.instance().show(context: context);
    try {
      final res = await RexApi.instance.completeOnboard(request: request);
      LoadingScreen.instance().hide();
      showModalActionSuccess(
        context: context,
        subtitle: StringAssets.accountCreatedTitle(res.accountNumber ?? 'n/a'),
        onPressed: () {
          ref.read(setTransactionPinProvider.notifier).toggleFromSignUp(true);
          context.push(Routes.setTransactionPin);
        },
      );
    } catch (error) {
      LoadingScreen.instance().hide();
      showModalActionError(context: context, errorText: error.toString());
    }
  }

  void _intializeDocumentsForCooperative() {
    final utility = CustomerDocumentDto(
      documentType: BusinessFileEnum.UTILITY_BILL.title,
      documentName: state.utilityBillDocName,
      documentPath: state.utilityBillDocPath,
      documentRefNo: '',
      documentTitle: BusinessFileEnum.UTILITY_BILL.title,
    );
    final registerCert = CustomerDocumentDto(
      documentType: BusinessFileEnum.CERTIFICATE_OF_REGISTRATION.title,
      documentName: state.registerCertDocName,
      documentPath: state.registerCertDocPath,
      documentRefNo: '',
      documentTitle: BusinessFileEnum.CERTIFICATE_OF_REGISTRATION.title,
    );
    final resAccount = CustomerDocumentDto(
      documentType: BusinessFileEnum.RESOLUTION_ACCOUNT_OPENING.title,
      documentName: state.resAccountDocName,
      documentPath: state.resAccountDocPath,
      documentRefNo: '',
      documentTitle: BusinessFileEnum.RESOLUTION_ACCOUNT_OPENING.title,
    );
    final constitution = CustomerDocumentDto(
      documentType: BusinessFileEnum.COPY_OF_CONSTITUTION.title,
      documentName: state.constitutionDocName,
      documentPath: state.constitutionDocPath,
      documentRefNo: '',
      documentTitle: BusinessFileEnum.COPY_OF_CONSTITUTION.title,
    );
    state = state.copyWith(businessDocs: [
      utility,
      registerCert,
      resAccount,
      constitution,
    ]);
  }
}
