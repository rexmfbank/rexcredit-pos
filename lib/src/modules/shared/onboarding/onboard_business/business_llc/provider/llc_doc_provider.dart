// ignore_for_file: camel_case_types, use_build_context_synchronously

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_api/rex_api.dart';
import 'package:rex_app/src/config/routes/route_name.dart';
import 'package:rex_app/src/modules/shared/onboarding/onboard_business/common/model/business_file_enum.dart';
import 'package:rex_app/src/modules/shared/onboarding/onboard_business/business_llc/model/llc_document_state.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/loading_screen.dart';
import 'package:rex_app/src/modules/shared/widgets/modal_bottom_sheets/show_modal_action.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

final llcDocProvider = NotifierProvider<LLC_DocNotifier, LLC_DocumentState>(() {
  return LLC_DocNotifier();
});

class LLC_DocNotifier extends Notifier<LLC_DocumentState> {
  @override
  LLC_DocumentState build() {
    return const LLC_DocumentState(
      utilityBill: BusinessFileStatus.fileIsNull,
      cacCert: BusinessFileStatus.fileIsNull,
      memorandum: BusinessFileStatus.fileIsNull,
      formCo7: BusinessFileStatus.fileIsNull,
      formCo2: BusinessFileStatus.fileIsNull,
      resBoard: BusinessFileStatus.fileIsNull,
      businessDocs: [],
      //
      utilityBillFile: null,
      utilityBillFileName: '',
      utilityBillDocName: '',
      utilityBillDocPath: '',
      //
      cacCertFile: null,
      cacCertFileName: '',
      cacCertDocName: '',
      cacCertDocPath: '',
      //
      memorandumFile: null,
      memorandumFileName: '',
      memorandumDocName: '',
      memorandumDocPath: '',
      //
      formCo7File: null,
      formCo7FileName: '',
      formCo7DocName: '',
      formCo7DocPath: '',
      //
      formCo2File: null,
      formCo2FileName: '',
      formCo2DocName: '',
      formCo2DocPath: '',
      //
      resBoardFile: null,
      resBoardFileName: '',
      resBoardDocName: '',
      resBoardDocPath: '',
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
      } else if (docType == BusinessFileEnum.MEMORANDUM_OF_ASSOCIATION) {
        state = state.copyWith(memorandumFile: file);
        uploadMemorandumToServer();
      } else if (docType == BusinessFileEnum.FORM_Co2) {
        state = state.copyWith(formCo2File: file);
        uploadFormCo2ToServer();
      } else if (docType == BusinessFileEnum.FORM_Co7) {
        state = state.copyWith(formCo7File: file);
        uploadFormCo7ToServer();
      } else if (docType == BusinessFileEnum.BOARD_RESOLUTION) {
        state = state.copyWith(resBoardFile: file);
        uploadResolutionBoardToServer();
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

  Future<void> uploadMemorandumToServer() async {
    String fileName = File(state.memorandumFile!.path).uri.pathSegments.last;
    state = state.copyWith(memorandumFileName: fileName);
    state = state.copyWith(memorandum: BusinessFileStatus.fileIsNotNull);
    try {
      state = state.copyWith(memorandum: BusinessFileStatus.fileIsUploading);
      final uploadResponse = await RexApi.instance.uploadFile(
        filePath: state.memorandumFile!.path,
        fileName: fileName,
      );
      state = state.copyWith(
        memorandum: BusinessFileStatus.fileIsUploaded,
        memorandumDocName: uploadResponse.data?.id,
        memorandumDocPath: uploadResponse.data?.refNo,
      );
    } catch (error) {
      state = state.copyWith(
        memorandum: BusinessFileStatus.fileUploadError,
        memorandumFile: null,
        memorandumDocName: '',
        memorandumDocPath: '',
      );
    }
  }

  Future<void> uploadFormCo7ToServer() async {
    String fileName = File(state.formCo7File!.path).uri.pathSegments.last;
    state = state.copyWith(formCo7FileName: fileName);
    state = state.copyWith(formCo7: BusinessFileStatus.fileIsNotNull);
    try {
      state = state.copyWith(formCo7: BusinessFileStatus.fileIsUploading);
      final uploadResponse = await RexApi.instance.uploadFile(
        filePath: state.formCo7File!.path,
        fileName: fileName,
      );
      state = state.copyWith(
        formCo7: BusinessFileStatus.fileIsUploaded,
        formCo7DocName: uploadResponse.data?.id,
        formCo7DocPath: uploadResponse.data?.refNo,
      );
    } catch (error) {
      state = state.copyWith(
        formCo7: BusinessFileStatus.fileUploadError,
        formCo7File: null,
        formCo7DocName: '',
        formCo7DocPath: '',
      );
    }
  }

  Future<void> uploadFormCo2ToServer() async {
    String fileName = File(state.formCo2File!.path).uri.pathSegments.last;
    state = state.copyWith(formCo2FileName: fileName);
    state = state.copyWith(formCo2: BusinessFileStatus.fileIsNotNull);
    try {
      state = state.copyWith(formCo2: BusinessFileStatus.fileIsUploading);
      final uploadResponse = await RexApi.instance.uploadFile(
        filePath: state.formCo2File!.path,
        fileName: fileName,
      );
      state = state.copyWith(
        formCo2: BusinessFileStatus.fileIsUploaded,
        formCo2DocName: uploadResponse.data?.id,
        formCo2DocPath: uploadResponse.data?.refNo,
      );
    } catch (error) {
      state = state.copyWith(
        formCo2: BusinessFileStatus.fileUploadError,
        formCo2File: null,
        formCo2DocName: '',
        formCo2DocPath: '',
      );
    }
  }

  Future<void> uploadResolutionBoardToServer() async {
    String fileName = File(state.resBoardFile!.path).uri.pathSegments.last;
    state = state.copyWith(resBoardFileName: fileName);
    state = state.copyWith(resBoard: BusinessFileStatus.fileIsNotNull);
    try {
      state = state.copyWith(resBoard: BusinessFileStatus.fileIsUploading);
      final uploadResponse = await RexApi.instance.uploadFile(
        filePath: state.resBoardFile!.path,
        fileName: fileName,
      );
      state = state.copyWith(
        resBoard: BusinessFileStatus.fileIsUploaded,
        resBoardDocName: uploadResponse.data?.id,
        resBoardDocPath: uploadResponse.data?.refNo,
      );
    } catch (error) {
      state = state.copyWith(
        resBoard: BusinessFileStatus.fileUploadError,
        resBoardFile: null,
        resBoardDocName: '',
        resBoardDocPath: '',
      );
    }
  }

  void validateDocuments(BuildContext context) {
    if (state.cacCertFile == null ||
        state.formCo2File == null ||
        state.formCo7File == null ||
        state.resBoardFile == null ||
        state.utilityBillFile == null ||
        state.memorandumFile == null) {
      showModalActionError(
        context: context,
        errorText: StringAssets.emptyDocs2,
        title: StringAssets.emptyDocs1,
      );
    } else {
      _intializeDocumentsForLLC();
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
      await RexApi.instance.completeOnboard(request: request);
      LoadingScreen.instance().hide();
      context.push(RouteName.bizllcDirector);
    } catch (error) {
      LoadingScreen.instance().hide();
      showModalActionError(context: context, errorText: error.toString());
    }
  }

  void _intializeDocumentsForLLC() {
    final docMemo = CustomerDocumentDto(
      documentType: BusinessFileEnum.MEMORANDUM_OF_ASSOCIATION.title,
      documentName: state.memorandumDocName,
      documentPath: state.memorandumDocPath,
      documentRefNo: '',
      documentTitle: BusinessFileEnum.MEMORANDUM_OF_ASSOCIATION.title,
    );
    final utility = CustomerDocumentDto(
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
    final formCo2 = CustomerDocumentDto(
      documentType: BusinessFileEnum.FORM_Co2.title,
      documentName: state.formCo2DocName,
      documentPath: state.formCo2DocPath,
      documentRefNo: '',
      documentTitle: BusinessFileEnum.FORM_Co2.title,
    );
    final formCo7 = CustomerDocumentDto(
      documentType: BusinessFileEnum.FORM_Co7.title,
      documentName: state.formCo7DocName,
      documentPath: state.formCo7DocPath,
      documentRefNo: '',
      documentTitle: BusinessFileEnum.FORM_Co7.title,
    );
    final resBoard = CustomerDocumentDto(
      documentType: BusinessFileEnum.BOARD_RESOLUTION.title,
      documentName: state.resBoardDocName,
      documentPath: state.resBoardDocPath,
      documentRefNo: '',
      documentTitle: BusinessFileEnum.BOARD_RESOLUTION.title,
    );
    state = state.copyWith(businessDocs: [
      docMemo,
      utility,
      cacCert,
      formCo2,
      formCo7,
      resBoard,
    ]);
  }
}
