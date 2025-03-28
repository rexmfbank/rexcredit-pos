import 'package:dio/dio.dart';
import 'package:rex_api/rex_api.dart';
import 'package:rex_api/src/endpoints/shared_models/api_headers.dart';
import 'package:rex_api/src/exceptions/string_constants.dart';

import '../../../exceptions/data_transformer.dart';
import '../../../exceptions/rex_api_exception.dart';
import '../../../utils/api_path.dart';
import '../../../utils/dio_network_provider.dart';

mixin ProductCategoryApi {
  static final _tokenProvider = AppNetworkProvider();

  Future<CreateProductCategoryResponse> createProductCategory({
    required String authToken,
    required CreateProductCategoryRequest request,
  }) async {
    final response = await _tokenProvider.call(
      path: ApiPath.createProductCategory,
      method: RequestMethod.post,
      body: request.toJson(),
      options: Options(
        headers: ApiHeaders.transactionRequestHeaderToken(authToken),
      ),
    );

    final res =
    processData((p0) => CreateProductCategoryResponse.fromJson(p0), response);
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

  Future<UpdateProductCategoryResponse> updateProductCategory({
    required String authToken,
    required UpdateProductCategoryRequest request,
  }) async {
    final response = await _tokenProvider.call(
      path: ApiPath.updateProductCategory,
      method: RequestMethod.post,
      body: request.toJson(),
      options: Options(
        headers: ApiHeaders.transactionRequestHeaderToken(authToken),
      ),
    );

    final res =
    processData((p0) => UpdateProductCategoryResponse.fromJson(p0), response);
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

  Future<ProductCategoriesResponse> getProductCategories({
    required String authToken,
  }) async {
    final response = await _tokenProvider.call(
      path: ApiPath.getProductCategories,
      method: RequestMethod.get,
      options: Options(
        headers: ApiHeaders.transactionRequestHeaderToken(authToken),
      ),
    );

    final res =
    processData((p0) => ProductCategoriesResponse.fromJson(p0), response);
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
}
