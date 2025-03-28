import 'package:dio/dio.dart';
import 'package:rex_api/rex_api.dart';
import 'package:rex_api/src/endpoints/shared_models/api_headers.dart';
import 'package:rex_api/src/exceptions/data_transformer.dart';
import 'package:rex_api/src/exceptions/rex_api_exception.dart';
import 'package:rex_api/src/exceptions/string_constants.dart';
import 'package:rex_api/src/utils/api_path.dart';
import 'package:rex_api/src/utils/dio_network_provider.dart';

mixin KycDocsApi {
  static final _tokenProvider = AppNetworkProvider();

  Future<GetKycDocsResponse> getKycDocs({
    required String authToken,
    required GetKycDocsQuery query,
  }) async {
    final response = await _tokenProvider.call(
      path: ApiPath.getKycDocuments,
      method: RequestMethod.get,
      queryParams: query.toJson(),
      options: Options(
        headers: ApiHeaders.transactionRequestHeaderToken(authToken),
      ),
    );

    final res = processData((p0) => GetKycDocsResponse.fromJson(p0), response);
    res.either(
      (left) => throw RexApiException(
          message:
              res.left.responseMessage ?? StringConstants.exceptionMessage),
      (right) => _tokenProvider.parseResponse(
        responseCode: res.isRight ? res.right.responseCode : '',
        errorAction: () =>
            throw RexApiException(message: res.right.responseMessage),
      ),
    );

    return res.right;
  }

  Future<GetKycDocsResponse> uploadKycDocs({
    required String authToken,
    required KycUploadQuery query,
    required FileFormData fileData,
  }) async {
    final response = await _tokenProvider.call(
      path: ApiPath.uploadKYCDocuments,
      method: RequestMethod.post,
      queryParams: query.toJson(),
      body: FormData.fromMap({
        "file": await MultipartFile.fromFile(
          fileData.filePath,
          filename: fileData.fileName,
        )
      }),
      options: Options(
        headers: ApiHeaders.requestHeaderWithToken(authToken),
      ),
    );

    final res = processData((p0) => GetKycDocsResponse.fromJson(p0), response);
    res.either(
      (left) => throw RexApiException(
          message:
              res.left.responseMessage ?? StringConstants.exceptionMessage),
      (right) => _tokenProvider.parseResponse(
        responseCode: res.isRight ? res.right.responseCode : '',
        errorAction: () =>
            throw RexApiException(message: res.right.responseMessage),
      ),
    );

    return res.right;
  }

  Future<SaveKycDocsResponse> saveKycDocs({
    required String authToken,
    required SaveKycDocsRequest request,
  }) async {
    final response = await _tokenProvider.call(
      path: ApiPath.saveDocument,
      method: RequestMethod.post,
      body: request.toJson(),
      options: Options(
        headers: ApiHeaders.requestHeaderWithToken(authToken),
      ),
    );

    final res = processData((p0) => SaveKycDocsResponse.fromJson(p0), response);
    res.either(
      (left) => throw RexApiException(
          message:
              res.left.responseMessage ?? StringConstants.exceptionMessage),
      (right) => _tokenProvider.parseResponse(
        responseCode: res.isRight ? res.right.responseCode : '',
        errorAction: () =>
            throw RexApiException(message: res.right.responseMessage),
      ),
    );

    return res.right;
  }
}
