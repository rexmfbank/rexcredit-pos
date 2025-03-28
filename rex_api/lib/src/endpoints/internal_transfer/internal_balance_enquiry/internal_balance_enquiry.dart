import 'package:dio/dio.dart';
import 'package:rex_api/rex_api.dart';
import 'package:rex_api/src/endpoints/shared_models/api_headers.dart';
import 'package:rex_api/src/exceptions/data_transformer.dart';
import 'package:rex_api/src/exceptions/rex_api_exception.dart';
import 'package:rex_api/src/exceptions/string_constants.dart';
import 'package:rex_api/src/utils/api_path.dart';
import 'package:rex_api/src/utils/dio_network_provider.dart';

mixin InternalBalanceEnquiry {
  Future<InternalBalanceEnquiryResponse> makeInternalBalanceEnquiry({
    required String token,
    required InternalBalanceEnquiryRequest request,
  }) async {
    final tokenProvider = AppNetworkProvider();

    final apiCall = await tokenProvider.call(
      path: ApiPath.internalBalanceEnquiry,
      method: RequestMethod.post,
      options: Options(headers: ApiHeaders.transactionRequestHeaderToken(token)),
      body: request.toJson(),
    );

    final res = processData(
      (p0) => InternalBalanceEnquiryResponse.fromJson(p0),
      apiCall,
    );

    res.either(
      (left) => throw RexApiException(
        message: res.left.message ?? StringConstants.exceptionMessage,
      ),
      (right) => tokenProvider.parseResponse(
        responseCode: res.isRight ? res.right.responseCode : '',
        errorAction: () => throw RexApiException(
          message: res.right.responseMessage,
        ),
      ),
    );

    return res.right;
  }
}
