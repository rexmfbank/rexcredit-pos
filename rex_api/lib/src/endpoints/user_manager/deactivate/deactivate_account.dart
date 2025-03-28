import 'package:dio/dio.dart';
import 'package:rex_api/src/endpoints/shared_models/api_headers.dart';
import 'package:rex_api/src/endpoints/user_manager/deactivate/models/deactivate_response.dart';
import 'package:rex_api/src/exceptions/data_transformer.dart';
import 'package:rex_api/src/exceptions/rex_api_exception.dart';
import 'package:rex_api/src/exceptions/string_constants.dart';
import 'package:rex_api/src/utils/api_path.dart';
import 'package:rex_api/src/utils/dio_network_provider.dart';

mixin DeactivateAccount {
  Future<DeactivateResponse> deactivateAccount({
    required String authToken,
  }) async {
    final tokenProvider = AppNetworkProvider();

    final apiCall = await tokenProvider.call(
      path: ApiPath.deactivateAccount,
      method: RequestMethod.post,
      options: Options(headers: ApiHeaders.requestHeaderWithToken(authToken)),
    );

    final res = processData(
      (p0) => DeactivateResponse.fromJson(p0),
      apiCall,
    );

    res.either(
      (left) => throw RexApiException(
        message: res.left.responseMessage ?? StringConstants.exceptionMessage,
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
