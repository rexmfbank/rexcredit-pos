import 'package:dio/dio.dart';
import '../../shared_models/api_headers.dart';
import 'models/create_dispute_request.dart';
import 'models/create_dispute_response.dart';
import 'models/fetch_dispute_response.dart';
import '../../../exceptions/data_transformer.dart';
import '../../../exceptions/rex_api_exception.dart';
import '../../../exceptions/string_constants.dart';
import '../../../utils/api_path.dart';
import '../../../utils/dio_network_provider.dart';

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
      (left) {
        throw RexApiException(
          message: res.left.responseMessage ?? StringConstants.exceptionMessage,
        );
      },
      (right) => tokenProvider.parseResponse(
        responseCode: res.isRight ? res.right.responseCode : '',
        errorAction:
            () => throw RexApiException(message: res.right.responseMessage),
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

    final res = processData((p0) => FetchDisputeResponse.fromJson(p0), apiCall);

    res.either(
      (left) =>
          throw RexApiException(
            message:
                res.left.responseMessage ?? StringConstants.exceptionMessage,
          ),
      (right) => tokenProvider.parseResponse(
        responseCode: res.isRight ? res.right.responseCode : '',
        errorAction:
            () => throw RexApiException(message: res.right.responseMessage),
      ),
    );
    return res.right;
  }
}
