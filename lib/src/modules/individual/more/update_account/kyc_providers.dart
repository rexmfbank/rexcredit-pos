import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/data/rex_api/rex_api.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/revamp/login/providers/login_provider.dart';
import 'package:rex_app/src/modules/shared/models/kyc/kyc_view_model.dart';
import 'package:rex_app/src/modules/shared/models/kyc/upload_model.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/modal_bottom_sheets/show_modal_action.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';
import 'package:rex_app/src/utils/enums/account_type.dart';
import 'package:rex_app/src/utils/extensions/extension_on_string.dart';

final getKycDocListProvider = FutureProvider<List<KycDocInfo>?>((ref) async {
  final username = ref.watch(usernameProvider);
  final isIndividual = ref.watch(userIsIndividualProvider);
  final res = await RexApi.instance.getKycDocs(
    authToken: ref.read(userAuthTokenProvider) ?? '',
    query: GetKycDocsQuery(
      username: username,
      entityCode: 'RMB',
      category: isIndividual
          ? AccountType.individual.requestString
          : AccountType.business.requestString,
    ),
  );
  return res.data;
});

final kycNotifier =
    AutoDisposeNotifierProvider<KycNotifier, KycViewModel>(() => KycNotifier());

class KycNotifier extends AutoDisposeNotifier<KycViewModel> {
  @override
  KycViewModel build() {
    return KycViewModel(
      referenceController: TextEditingController(),
    );
  }

  bool kycVerifying(DocStatus status) {
    switch (status) {
      case DocStatus.accepted:
      case DocStatus.pending:
        return true;

      case DocStatus.unavailable:
      case DocStatus.rejected:
      case DocStatus.terminated:
        return false;

      default:
        return false;
    }
  }

  bool kycVerifying2(String status) {
    if (status == DocStatusv2.accepted.value) {
      return true;
    } else if (status == DocStatusv2.rejected.value) {
      return false;
    } else if (status == DocStatusv2.pending.value) {
      return true;
    }
    return false;
  }

  Color? kycColor2(String status) {
    if (status == DocStatusv2.accepted.value) {
      return AppColors.rexGreen2;
    } else if (status == DocStatusv2.rejected.value) {
      return AppColors.redDark;
    } else if (status == DocStatusv2.pending.value) {
      return AppColors.rexBlue;
    }
    return null;
  }

  Color? kycColor(DocStatus status) {
    switch (status) {
      case DocStatus.accepted:
        return AppColors.rexGreen2;
      case DocStatus.pending:
        return AppColors.rexBlue;
      case DocStatus.unavailable:
        return null;
      case DocStatus.rejected:
        return AppColors.redDark;
      case DocStatus.terminated:
        return AppColors.redDark;

      default:
        return null;
    }
  }

  void getKycDocInfo(BuildContext context) async {
    //final loginInfo = ref.read(loginProvider).loginResponse.value?.data;
    final username = ref.watch(usernameProvider);
    final isIndividual = ref.watch(userIsIndividualProvider);
    //
    state = state.copyWith(isLoading: true);
    try {
      final res = await RexApi.instance.getKycDocs(
        authToken: ref.read(userAuthTokenProvider) ?? '',
        query: GetKycDocsQuery(
          //username: loginInfo?.username ?? '',
          username: username,
          entityCode: 'RMB',
          // category: loginInfo?.customerType == AccountType.individual.jsonString
          //     ? AccountType.individual.requestString
          //     : AccountType.business.requestString,
          category: isIndividual
              ? AccountType.individual.requestString
              : AccountType.business.requestString,
        ),
      );
      state = state.copyWith(isLoading: false, kycInfo: res.data);
      debugPrint("KYC INFO: ${res.data}");
    } catch (error, _) {
      state = state.copyWith(isLoading: false);
      if (context.mounted) {
        showModalActionError(
          context: context,
          errorText: error.toString(),
        );
      }
    }
  }

  void selectKyc(KycDocInfo kyc) =>
      state = state.copyWith(selectedKycInfo: kyc);

  void updateFileDetails(UploadModel model) => state = state.copyWith(
        fileFromDevice: model.fileFromDevice,
        fileName: model.fileName,
      );

  void validateUpload({
    required BuildContext context,
    required bool referenceRequired,
  }) {
    if ((referenceRequired && state.referenceController.text.isNotBlank) ||
        state.fileFromDevice != null) {
      uploadKycDocuments(context);
      return;
    }
    showModalActionError(
      context: context,
      title: StringAssets.validationError,
      errorText: StringAssets.pleaseFillAllFields,
    );
  }

  Future<void> uploadKycDocuments(
    BuildContext context, [
    VoidCallback? onSuccess,
  ]) async {
    LoginResponseData? loginData =
        ref.read(loginProvider).loginResponse.value?.data;
    state = state.copyWith(isLoading: true);
    try {
      final uploadResponse = await RexApi.instance.uploadKycDocs(
          authToken: ref.read(userAuthTokenProvider) ?? '',
          query: KycUploadQuery(
            entityCode: loginData?.entityCode ?? '',
            username: loginData?.username ?? '',
            documentType: state.selectedKycInfo?.documentType ?? '',
            documentName: state.fileName ?? '',
            accountNo: loginData?.primaryAccountNo ?? '',
            documentTitle: state.selectedKycInfo?.documentTitle ?? '',
          ),
          fileData: FileFormData(
            filePath: state.fileFromDevice!.path,
            fileName: state.fileName ?? 'file',
          ));
      state = state.copyWith(isLoading: false);
      getKycDocInfo(context);
      ref.read(getKycDocListProvider);
      onSuccess?.call();
      if (context.mounted) {
        showModalActionSuccess(
          context: context,
          enableDrag: false,
          subtitle: StringAssets.documentUploadedSuccessfully,
          onPressed: () {
            context.pop();
            context.pop();
            getKycDocInfo(context);
          },
        );
      }
    } catch (error) {
      state = state.copyWith(isLoading: false);
      if (context.mounted) {
        showModalActionError(
          context: context,
          errorText: error.toString(),
        );
      }
    }
  }

  Future<void> uploadFileToServer(BuildContext context,
      [VoidCallback? onSuccess]) async {
    String fileName = File(state.fileFromDevice!.path).uri.pathSegments.last;
    state = state.copyWith(
      isLoading: true,
      fileName: fileName,
    );
    try {
      final uploadResponse = await RexApi.instance.uploadFile(
        filePath: state.fileFromDevice!.path,
        fileName: fileName,
      );
      state = state.copyWith(
        isLoading: false,
        documentName: uploadResponse.data?.id,
        documentPath: uploadResponse.data?.refNo,
        docModel: UploadModel(
          fileFromDevice: state.fileFromDevice!,
          fileName: fileName,
          documentName: uploadResponse.data?.id,
          documentPath: uploadResponse.data?.refNo,
        ),
      );
      onSuccess?.call();
      if (context.mounted) {
        showModalActionSuccess(
          context: context,
          enableDrag: false,
          subtitle: StringAssets.documentUploadedSuccessfully,
          onPressed: () {
            context.pop();
            context.pop();
            getKycDocInfo(context);
          },
        );
      }
    } catch (error) {
      state = state.copyWith(isLoading: false);
      if (context.mounted) {
        showModalActionError(
          context: context,
          errorText: error.toString(),
        );
      }
    }
  }
}
