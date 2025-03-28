import 'package:dio/dio.dart';
import 'package:rex_api/src/endpoints/inventory/shop/models/requests/search_staff_query.dart';
import 'package:rex_api/src/endpoints/inventory/shop/models/requests/shop_filter_request.dart';
import 'package:rex_api/src/endpoints/inventory/shop/models/requests/shop_request.dart';
import 'package:rex_api/src/endpoints/inventory/shop/models/response/search_store_response.dart';
import 'package:rex_api/src/endpoints/inventory/shop/models/response/shop_data.dart';
import 'package:rex_api/src/endpoints/inventory/shop/models/response/shop_response.dart';
import 'package:rex_api/src/endpoints/inventory/shop/models/response/shop_transactions_response.dart';
import 'package:rex_api/src/endpoints/shared_models/api_headers.dart';
import 'package:rex_api/src/exceptions/data_transformer.dart';
import 'package:rex_api/src/exceptions/rex_api_exception.dart';
import 'package:rex_api/src/exceptions/string_constants.dart';
import 'package:rex_api/src/utils/api_path.dart';
import 'package:rex_api/src/utils/dio_network_provider.dart';

mixin ShopApi {
  static final _tokenProvider = AppNetworkProvider();

  Future<GetStoresResponse> getShops({required String authToken}) async {
    final response = await _tokenProvider.call(
      path: ApiPath.getStores,
      method: RequestMethod.get,
      options: Options(
        headers: ApiHeaders.transactionRequestHeaderToken(authToken),
      ),
    );

    final res = processData((p0) => GetStoresResponse.fromJson(p0), response);
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

  Future<ShopData> deleteStore(
      {required String authToken, required String storeCode}) async {
    final response = await _tokenProvider.call(
      path: ApiPath.deleteStore(storeCode),
      method: RequestMethod.delete,
      options: Options(
        headers: ApiHeaders.transactionRequestHeaderToken(authToken),
      ),
    );

    final res = processData((p0) => ShopData.fromJson(p0), response);
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

  Future<ShopData> createStore(
      {required String authToken, required ShopRequest request}) async {
    final response = await _tokenProvider.call(
      path: ApiPath.createStore,
      method: RequestMethod.post,
      body: request.toJson(),
      options: Options(
        headers: ApiHeaders.transactionRequestHeaderToken(authToken),
      ),
    );

    final res = processData((p0) => ShopData.fromJson(p0), response);
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

  Future<ShopData> editStore(
      {required String authToken, required ShopRequest request}) async {
    final response = await _tokenProvider.call(
      path: ApiPath.editStore,
      method: RequestMethod.post,
      body: request.toJson(),
      options: Options(
        headers: ApiHeaders.transactionRequestHeaderToken(authToken),
      ),
    );

    final res = processData((p0) => ShopData.fromJson(p0), response);
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

  Future<ShopTransactionsResponse> getStoreOrders(
      {required String authToken, required ShopFilterRequest request}) async {
    final response = await _tokenProvider.call(
      path: ApiPath.getShopOrders,
      method: RequestMethod.post,
      body: request.toJson(),
      options: Options(
        headers: ApiHeaders.transactionRequestHeaderToken(authToken),
      ),
    );

    final res = processData((p0) => ShopTransactionsResponse.fromJson(p0), response);
    res.either(
      (left) => throw RexApiException(
          message: res.left.responseMessage ?? StringConstants.exceptionMessage),
      (right) => _tokenProvider.parseResponse(
        responseCode: res.isRight ? res.right.responseCode! : '',
        errorAction: () =>
            throw RexApiException(message: res.right.responseMessage),
      ),
    );

    return res.right;
  }

  Future<SearchStoreResponse> searchStaff({required String authToken, required SearchStaffQuery query}) async {
    final response = await _tokenProvider.call(
      path: ApiPath.searchStaff,
      method: RequestMethod.get,
      queryParams: query.toJson(),
      options: Options(
        headers: ApiHeaders.requestHeaderWithToken(authToken),
      ),
    );

    final res = processData((p0) => SearchStoreResponse.fromJson(p0), response);
    res.either(
          (left) => throw RexApiException(
          message: res.left.responseMessage ?? StringConstants.exceptionMessage),
          (right) => _tokenProvider.parseResponse(
        responseCode: res.isRight ? res.right.responseCode! : '',
        errorAction: () =>
        throw RexApiException(message: res.right.responseMessage),
      ),
    );

    return res.right;
  }
}
