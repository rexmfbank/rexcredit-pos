import 'package:dio/dio.dart';
import 'package:rex_app/src/modules/revamp/utils/data/rex_api/rex_api.dart';
import '../../shared_models/api_headers.dart';
import '../../../exceptions/data_transformer.dart';
import '../../../exceptions/rex_api_exception.dart';
import '../../../exceptions/string_constants.dart';
import '../../../utils/api_path.dart';
import '../../../utils/dio_network_provider.dart';

mixin InternalBalanceEnquiry {
  Future<InternalBalanceEnquiryResponse> makeInternalBalanceEnquiry({
    required String token,
    required InternalBalanceEnquiryRequest request,
  }) async {
    final tokenProvider = AppNetworkProvider();

    final apiCall = await tokenProvider.call(
      path: ApiPath.internalBalanceEnquiry,
      method: RequestMethod.post,
      options:
          Options(headers: ApiHeaders.transactionRequestHeaderToken(token)),
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
