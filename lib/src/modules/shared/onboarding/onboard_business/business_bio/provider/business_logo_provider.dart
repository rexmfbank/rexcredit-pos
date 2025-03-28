import 'dart:io';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import 'package:rex_api/rex_api.dart';
import 'package:rex_app/src/modules/shared/onboarding/onboard_business/business_bio/model/business_logo_state.dart';

final businessLogoProvider =
    NotifierProvider<BusinessLogoNotifier, BusinessLogoState>(
  () => BusinessLogoNotifier(),
);

class BusinessLogoNotifier extends Notifier<BusinessLogoState> {
  @override
  BusinessLogoState build() {
    return const BusinessLogoState(
      imageFromDevice: null,
      documentName: '',
      documentPath: '',
    );
  }

  Future<void> getImageFromDevice() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 40,
    );
    if (image == null) return;
    final imageFile = File(image.path);
    final imageFileName = File(imageFile.path).uri.pathSegments.last;
    state = state.copyWith(imageFromDevice: imageFile, fileName: imageFileName);
    uploadFileToServer();
  }

  Future<void> uploadFileToServer() async {
    try {
      final uploadResponse = await RexApi.instance.uploadFile(
        filePath: state.imageFromDevice?.path ?? '',
        fileName: state.fileName ?? '',
      );
      state = state.copyWith(
        documentName: uploadResponse.data?.id,
        documentPath: uploadResponse.data?.refNo,
      );
    } catch (error) {
      state = state.copyWith(documentName: '', documentPath: '');
    }
  }

  // Future<void> uploadFileInThread() async {
  //   final sd = computeUpload(
  //     UploadFileParam(
  //       filePath: state.imageFromDevice?.path ?? '',
  //       fileName: state.fileName ?? '',
  //     ),
  //   );
  //   print("file >>>>>>>>>>>>== ${sd.then((value) => value)}");
  // }
}

// Future<String> computeUpload(UploadFileParam param) async {
//   return compute(uploadFileAndReturnUrl, param);
// }

// Future<String> uploadFileAndReturnUrl(UploadFileParam param) async {
//   final str = await RexApi.instance.uploadFileAndReturnUrl(param: param);
//   return str;
// }
