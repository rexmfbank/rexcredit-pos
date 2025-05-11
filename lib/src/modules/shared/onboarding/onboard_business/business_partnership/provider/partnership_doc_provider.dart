// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/data/rex_api/rex_api.dart';
import 'package:rex_app/src/config/routes/route_name.dart';
import 'package:rex_app/src/modules/shared/onboarding/onboard_business/business_partnership/model/partnership_doc_state.dart';
import 'package:rex_app/src/modules/shared/onboarding/onboard_business/common/model/business_file_enum.dart';
import 'package:rex_app/src/modules/shared/onboarding/set_transaction_pin/provider/set_transaction_pin_provider.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/loading_screen.dart';
import 'package:rex_app/src/modules/shared/widgets/modal_bottom_sheets/show_modal_action.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

final partnershipDocProvider =
    NotifierProvider<PartnershipDocNotifier, PartnershipDocState>(
  () => PartnershipDocNotifier(),
);

class PartnershipDocNotifier extends Notifier<PartnershipDocState> {
  @override
  PartnershipDocState build() {
    return const PartnershipDocState(
      utilityBill: BusinessFileStatus.fileIsNull,
      cacCert: BusinessFileStatus.fileIsNull,
      cacApply: BusinessFileStatus.fileIsNull,
      deed: BusinessFileStatus.fileIsNull,
      resAccount: BusinessFileStatus.fileIsNull,
      businessDocs: [],
      utilityBillFile: null,
      utilityBillFileName: '',
      utilityBillDocName: '',
      utilityBillDocPath: '',
      cacCertFile: null,
      cacCertFileName: '',
      cacCertDocName: '',
      cacCertDocPath: '',
      cacApplyFile: null,
      cacApplyFileName: '',
      cacApplyDocName: '',
      cacApplyDocPath: '',
      deedFile: null,
      deedFileName: '',
      deedDocName: '',
      deedDocPath: '',
      resAccountFile: null,
      resAccountFileName: '',
      resAccountDocName: '',
      resAccountDocPath: '',
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
      } else if (docType == BusinessFileEnum.CAC_CERTIFICATE_REGISTRATION) {
        state = state.copyWith(cacCertFile: file);
        uploadCacCertToServer();
      } else if (docType == BusinessFileEnum.RESOLUTION_ACCOUNT_OPENING) {
        state = state.copyWith(resAccountFile: file);
        uploadResAccountToServer();
      } else if (docType == BusinessFileEnum.PARTNERSHIP_DEED) {
        state = state.copyWith(deedFile: file);
        uploadDeedToServer();
      } else if (docType == BusinessFileEnum.CAC_REGISTRATION_APPLICATION) {
        state = state.copyWith(cacApplyFile: file);
        uploadCacApplyToServer();
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

  Future<void> uploadCacCertToServer() async {
    String fileName = File(state.cacCertFile!.path).uri.pathSegments.last;
    state = state.copyWith(cacCertFileName: fileName);
    state = state.copyWith(cacCert: BusinessFileStatus.fileIsNotNull);
    try {
      state = state.copyWith(cacCert: BusinessFileStatus.fileIsUploading);
      final uploadResponse = await RexApi.instance.uploadFile(
        filePath: state.cacCertFile!.path,
        fileName: fileName,
      );
      state = state.copyWith(
        cacCert: BusinessFileStatus.fileIsUploaded,
        cacCertDocName: uploadResponse.data?.id,
        cacCertDocPath: uploadResponse.data?.refNo,
      );
    } catch (error) {
      state = state.copyWith(
        cacCert: BusinessFileStatus.fileUploadError,
        cacCertFile: null,
        cacCertDocName: '',
        cacCertDocPath: '',
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

  Future<void> uploadDeedToServer() async {
    String fileName = File(state.deedFile!.path).uri.pathSegments.last;
    state = state.copyWith(deedFileName: fileName);
    state = state.copyWith(deed: BusinessFileStatus.fileIsNotNull);
    try {
      state = state.copyWith(deed: BusinessFileStatus.fileIsUploading);
      final uploadResponse = await RexApi.instance.uploadFile(
        filePath: state.deedFile!.path,
        fileName: fileName,
      );
      state = state.copyWith(
        deed: BusinessFileStatus.fileIsUploaded,
        deedDocName: uploadResponse.data?.id,
        deedDocPath: uploadResponse.data?.refNo,
      );
    } catch (error) {
      state = state.copyWith(
        deed: BusinessFileStatus.fileUploadError,
        deedFile: null,
        deedDocName: '',
        deedDocPath: '',
      );
    }
  }

  Future<void> uploadCacApplyToServer() async {
    String fileName = File(state.cacApplyFile!.path).uri.pathSegments.last;
    state = state.copyWith(cacApplyFileName: fileName);
    state = state.copyWith(cacApply: BusinessFileStatus.fileIsNotNull);
    try {
      state = state.copyWith(cacApply: BusinessFileStatus.fileIsUploading);
      final uploadResponse = await RexApi.instance.uploadFile(
        filePath: state.cacApplyFile!.path,
        fileName: fileName,
      );
      state = state.copyWith(
        cacApply: BusinessFileStatus.fileIsUploaded,
        cacApplyDocName: uploadResponse.data?.id,
        cacApplyDocPath: uploadResponse.data?.refNo,
      );
    } catch (error) {
      state = state.copyWith(
        cacApply: BusinessFileStatus.fileUploadError,
        cacApplyFile: null,
        cacApplyDocName: '',
        cacApplyDocPath: '',
      );
    }
  }

  void validateDocuments(BuildContext context) {
    if (state.deedFile == null ||
        state.cacCertFile == null ||
        state.cacApplyFile == null ||
        state.resAccountFile == null ||
        state.utilityBillFile == null) {
      showModalActionError(
        context: context,
        errorText: StringAssets.emptyDocs2,
        title: StringAssets.emptyDocs1,
      );
    } else {
      _initializeDocumentsForPartnership();
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
          context.push(RouteName.setTransactionPin);
        },
      );
    } catch (error) {
      LoadingScreen.instance().hide();
      showModalActionError(context: context, errorText: error.toString());
    }
  }

  void _initializeDocumentsForPartnership() {
    final utilityBill = CustomerDocumentDto(
      documentType: BusinessFileEnum.UTILITY_BILL.title,
      documentName: state.utilityBillDocName,
      documentPath: state.utilityBillDocPath,
      documentRefNo: '',
      documentTitle: BusinessFileEnum.UTILITY_BILL.title,
    );
    final cacCert = CustomerDocumentDto(
      documentType: BusinessFileEnum.CAC_CERTIFICATE_REGISTRATION.title,
      documentName: state.cacCertDocName,
      documentPath: state.cacCertDocPath,
      documentRefNo: '',
      documentTitle: BusinessFileEnum.CAC_CERTIFICATE_REGISTRATION.title,
    );
    final cacApply = CustomerDocumentDto(
      documentType: BusinessFileEnum.CAC_REGISTRATION_APPLICATION.title,
      documentName: state.cacApplyDocName,
      documentPath: state.cacApplyDocPath,
      documentRefNo: '',
      documentTitle: BusinessFileEnum.CAC_REGISTRATION_APPLICATION.title,
    );
    final deed = CustomerDocumentDto(
      documentType: BusinessFileEnum.PARTNERSHIP_DEED.title,
      documentName: state.deedDocName,
      documentPath: state.deedDocPath,
      documentRefNo: '',
      documentTitle: BusinessFileEnum.PARTNERSHIP_DEED.title,
    );
    final resAccount = CustomerDocumentDto(
      documentType: BusinessFileEnum.RESOLUTION_ACCOUNT_OPENING.title,
      documentName: state.resAccountDocName,
      documentPath: state.resAccountDocPath,
      documentRefNo: '',
      documentTitle: BusinessFileEnum.RESOLUTION_ACCOUNT_OPENING.title,
    );
    state = state.copyWith(businessDocs: [
      utilityBill,
      cacCert,
      cacApply,
      deed,
      resAccount,
    ]);
  }
}
