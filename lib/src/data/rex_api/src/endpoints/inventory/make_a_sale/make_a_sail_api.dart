import 'package:dio/dio.dart';
import 'request/create_customer_request.dart';
import 'request/create_order_request.dart';
import 'request/search_customer_query.dart';
import 'response/create_customer_response.dart';
import 'response/create_order_response.dart';
import 'response/customer_response_model.dart';
import '../../shared_models/api_headers.dart';
import '../../../exceptions/data_transformer.dart';
import '../../../exceptions/rex_api_exception.dart';
import '../../../exceptions/string_constants.dart';
import '../../../utils/api_path.dart';
import '../../../utils/dio_network_provider.dart';

mixin MakeASaleApi {
  static final _tokenProvider = AppNetworkProvider();

  Future<CreateOrderResponse> createOrder(
      {required String authToken, required CreateOrderRequest request}) async {
    final response = await _tokenProvider.call(
      path: ApiPath.createOrder,
      method: RequestMethod.post,
      body: request.toJson(),
      options: Options(
        headers: ApiHeaders.transactionRequestHeaderToken(authToken),
      ),
    );

    final res = processData((p0) => CreateOrderResponse.fromJson(p0), response);
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

  Future<CustomerResponseModel> getCustomers(
      {required String authToken}) async {
    final response = await _tokenProvider.call(
      path: ApiPath.getCustomers,
      method: RequestMethod.get,
      options: Options(
        headers: ApiHeaders.transactionRequestHeaderToken(authToken),
      ),
    );

    final res = processData((p0) => CustomerResponseModel.fromJson(p0), response);
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

  Future<CreateCustomerResponse> createCustomer(
      {required String authToken, required CreateCustomerRequest request}) async {
    final response = await _tokenProvider.call(
      path: ApiPath.createCustomer,
      method: RequestMethod.post,
      body: request.toJson(),
      options: Options(
        headers: ApiHeaders.transactionRequestHeaderToken(authToken),
      ),
    );

    final res = processData((p0) => CreateCustomerResponse.fromJson(p0), response);
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

  Future<CustomerResponseModel> searchCustomer(
      {required String authToken, required SearchCustomerQuery query}) async {
    final response = await _tokenProvider.call(
      path: ApiPath.searchCustomer,
      method: RequestMethod.get,
      queryParams: query.toJson(),
      options: Options(
        headers: ApiHeaders.requestHeaderWithToken(authToken),
      ),
    );

    final res = processData((p0) => CustomerResponseModel.fromJson(p0), response);
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
