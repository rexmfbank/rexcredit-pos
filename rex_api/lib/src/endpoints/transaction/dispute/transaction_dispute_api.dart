import 'package:dio/dio.dart';
import 'package:rex_api/src/endpoints/shared_models/api_headers.dart';
import 'package:rex_api/src/endpoints/transaction/dispute/models/create_dispute_request.dart';
import 'package:rex_api/src/endpoints/transaction/dispute/models/create_dispute_response.dart';
import 'package:rex_api/src/endpoints/transaction/dispute/models/fetch_dispute_response.dart';
import 'package:rex_api/src/exceptions/data_transformer.dart';
import 'package:rex_api/src/exceptions/rex_api_exception.dart';
import 'package:rex_api/src/exceptions/string_constants.dart';
import 'package:rex_api/src/utils/api_path.dart';
import 'package:rex_api/src/utils/dio_network_provider.dart';

mixin TransactionDisputeApi {
  final tokenProvider = AppNetworkProvider();

  Future<CreateDisputeResponse> createDispute({
    required String authToken,
    required CreateDisputeRequest request,
  }) async {
    final apiCall = await tokenProvider.call(
      path: ApiPath.createDispute,
      method: RequestMethod.post,
      options: Options(headers: ApiHeaders.requestHeaderWithToken(authToken)),
      body: request.toJson(),
    );

    final res = processData(
      (p0) => CreateDisputeResponse.fromJson(p0),
      apiCall,
    );

    res.either(
      (left) => throw RexApiException(
          message: res.left.responseMessage ?? StringConstants.exceptionMessage),
      (right) => tokenProvider.parseResponse(
        responseCode: res.isRight ? res.right.responseCode : '',
        errorAction: () =>
            throw RexApiException(message: res.right.responseMessage),
      ),
    );
    return res.right;
  }

  Future<FetchDisputeResponse> fetchDisputes({
    required String authToken,
  }) async {
    final apiCall = await tokenProvider.call(
      path: ApiPath.fetchDispute,
      method: RequestMethod.post,
      options: Options(headers: ApiHeaders.requestHeaderWithToken(authToken)),
    );

    final res = processData(
      (p0) => FetchDisputeResponse.fromJson(p0),
      apiCall,
    );

    res.either(
      (left) => throw RexApiException(
          message: res.left.responseMessage ?? StringConstants.exceptionMessage),
      (right) => tokenProvider.parseResponse(
        responseCode: res.isRight ? res.right.responseCode : '',
        errorAction: () =>
            throw RexApiException(message: res.right.responseMessage),
      ),
    );
    return res.right;
  }
}
