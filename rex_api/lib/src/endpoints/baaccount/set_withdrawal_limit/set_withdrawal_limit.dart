import 'package:dio/dio.dart';
import 'package:rex_api/rex_api.dart';
import 'package:rex_api/src/endpoints/shared_models/api_headers.dart';
import 'package:rex_api/src/exceptions/rex_api_exception.dart';
import 'package:rex_api/src/utils/api_path.dart';
import 'package:rex_api/src/exceptions/string_constants.dart';

import '../../../exceptions/data_transformer.dart';
import '../../../utils/dio_network_provider.dart';

mixin SetWithdrawalLimit {
  static final _tokenProvider = AppNetworkProvider();

  Future<SetWithdrawalLimitResponse> setWithdrawalLimit({
    required String authToken,
    required SetWithdrawalLimitRequest request,
  }) async {
    final response = await _tokenProvider.call(
      path: ApiPath.setWithdrawalLimit,
      method: RequestMethod.post,
      body: request.toJson(),
      options: Options(
        headers: ApiHeaders.requestHeaderWithToken(authToken),
      ),
    );

    final res =
    processData((p0) => SetWithdrawalLimitResponse.fromJson(p0), response);
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
