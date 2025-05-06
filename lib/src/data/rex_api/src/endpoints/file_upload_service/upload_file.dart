import 'package:dio/dio.dart';
import 'request/upload_file_param.dart';
import '../shared_models/api_headers.dart';
import '../shared_models/image_upload_response.dart';
import '../../exceptions/data_transformer.dart';
import '../../exceptions/rex_api_exception.dart';
import '../../exceptions/string_constants.dart';
import '../../utils/api_path.dart';
import '../../utils/dio_network_provider.dart';

mixin UploadFile {
  static final _tokenProvider = AppNetworkProvider();

  Future<ImageUploadResponse> uploadFile({
    required String filePath,
    required String fileName,
  }) async {
    var formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(
        filePath,
        filename: fileName,
      )
    });

    final response = await _tokenProvider.call(
      path: ApiPath.uploadFile,
      method: RequestMethod.post,
      body: formData,
      options: Options(
        headers: ApiHeaders.requestHeader,
      ),
    );

    final res = processData((p0) => ImageUploadResponse.fromJson(p0), response);
    res.either(
      (left) => throw RexApiException(
          message: res.left.responseMessage ?? StringConstants.exceptionMessage),
      (right) => _tokenProvider.parseResponse(
        responseCode: res.isRight ? res.right.responseCode : '',
        errorAction: () =>
            throw RexApiException(message: res.right.responseMessage),
      ),
    );

    return res.right;
  }

  Future<String> uploadFileAndReturnUrl({
    required UploadFileParam param,
  }) async {
    var formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(
        param.filePath,
        filename: param.fileName,
      )
    });

    final response = await _tokenProvider.call(
      path: ApiPath.uploadFile,
      method: RequestMethod.post,
      body: formData,
      options: Options(
        headers: ApiHeaders.requestHeader,
      ),
    );

    final res = processData((p0) => ImageUploadResponse.fromJson(p0), response);
    res.either(
      (left) => throw RexApiException(
          message: res.left.responseMessage ?? StringConstants.exceptionMessage),
      (right) => _tokenProvider.parseResponse(
        responseCode: res.isRight ? res.right.responseCode : '',
        errorAction: () =>
            throw RexApiException(message: res.right.responseMessage),
      ),
    );

    return res.right.data?.refNo ?? '';
  }
}
