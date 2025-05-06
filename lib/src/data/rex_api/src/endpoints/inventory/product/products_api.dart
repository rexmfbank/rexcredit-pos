import 'package:dio/dio.dart';
import 'package:rex_app/src/data/rex_api/rex_api.dart';
import '../../../exceptions/data_transformer.dart';
import '../../../utils/dio_network_provider.dart';
import '../../../exceptions/string_constants.dart';
import 'package:http_parser/http_parser.dart';

import '../../../exceptions/rex_api_exception.dart';
import '../../../utils/api_path.dart';
import '../../shared_models/api_headers.dart';

mixin ProductsApi {
  static final _tokenProvider = AppNetworkProvider();

  Future<ProductListResponse> getProducts({
    required String authToken,
  }) async {
    final response = await _tokenProvider.call(
      path: ApiPath.listMerchantProducts,
      method: RequestMethod.get,
      options: Options(
        headers: ApiHeaders.transactionRequestHeaderToken(authToken),
      ),
    );

    final res = processData((p0) => ProductListResponse.fromJson(p0), response);
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

  Future<FilterProductResponse> getFilteredProducts({
    required String authToken,
    required FilterProductRequest request,
  }) async {
    final response = await _tokenProvider.call(
      path: ApiPath.filterProduct,
      method: RequestMethod.post,
      body: request.toJson(),
      options: Options(
        headers: ApiHeaders.transactionRequestHeaderToken(authToken),
      ),
    );

    final res =
        processData((p0) => FilterProductResponse.fromJson(p0), response);
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

  Future<ProductListResponse> getSearchedProduct({
    required String authToken,
    required SearchProductRequest request,
  }) async {
    final response = await _tokenProvider.call(
      path: ApiPath.searchProduct,
      method: RequestMethod.post,
      body: request.toJson(),
      options: Options(
        headers: ApiHeaders.transactionRequestHeaderToken(authToken),
      ),
    );

    final res = processData((p0) => ProductListResponse.fromJson(p0), response);
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

  Future<CreateProductResponse> addSingleProduct({
    required String authToken,
    required CreateProductRequest request,
  }) async {
    final response = await _tokenProvider.call(
      path: ApiPath.createProduct,
      method: RequestMethod.post,
      body: request.toJson(),
      options: Options(
        headers: ApiHeaders.transactionRequestHeaderToken(authToken),
      ),
    );

    final res =
        processData((p0) => CreateProductResponse.fromJson(p0), response);
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

  Future<CreateProductResponse> updateProduct({
    required String authToken,
    required CreateProductRequest request,
  }) async {
    final response = await _tokenProvider.call(
      path: ApiPath.updateProduct,
      method: RequestMethod.post,
      body: request.toJson(),
      options: Options(
        headers: ApiHeaders.transactionRequestHeaderToken(authToken),
      ),
    );

    final res =
        processData((p0) => CreateProductResponse.fromJson(p0), response);
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

  Future<ImageUploadResponse> uploadImageFile({
    required String authToken,
    required String filePath,
    required String fileName,
    required Function(double) onSendProgress,
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
      onSendProgress: onSendProgress,
      options: Options(
        headers: ApiHeaders.transactionRequestHeaderToken(authToken),
      ),
    );

    final res = processData((p0) => ImageUploadResponse.fromJson(p0), response);
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

  Future<CreateProductResponse> uploadBulkProducts({
    required String authToken,
    required BulkProductUploadQuery query,
    required String filePath,
    required String fileName,
  }) async {
    final response = await _tokenProvider.call(
      path: ApiPath.bulkUploadProducts,
      method: RequestMethod.post,
      queryParams: query.toJson(),
      body: FormData.fromMap({
        "file": await MultipartFile.fromFile(
          filePath,
          filename: fileName,
          contentType: MediaType('text', 'csv'),
        )
      }),
      options: Options(
        headers: ApiHeaders.transactionRequestHeaderToken(
          authToken,
        ),
      ),
    );

    final res =
        processData((p0) => CreateProductResponse.fromJson(p0), response);
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

  Future<bool> downloadBulkUploadTemplate({
    required String authToken,
    required String savePath,
  }) async {
    final response = await _tokenProvider.download(
      path: ApiPath.downloadBulkUploadTemplateFile,
      savePath: savePath,
      options: Options(
        headers: ApiHeaders.transactionRequestHeaderToken(authToken),
      ),
    );

    response.either((left) {
      throw RexApiException(message: StringConstants.exceptionMessage);
    }, (right) => true);
    return true;
  }
}
