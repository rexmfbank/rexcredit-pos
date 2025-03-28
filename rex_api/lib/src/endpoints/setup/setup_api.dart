import 'package:dio/dio.dart';
import 'package:rex_api/src/endpoints/setup/response/force_update_response.dart';
import 'package:rex_api/src/endpoints/shared_models/api_headers.dart';
import 'package:rex_api/src/exceptions/data_transformer.dart';
import 'package:rex_api/src/exceptions/rex_api_exception.dart';
import 'package:rex_api/src/exceptions/string_constants.dart';
import 'package:rex_api/src/utils/api_path.dart';
import 'package:rex_api/src/utils/dio_network_provider.dart';

mixin Setup{
  static final _tokenProvider = AppNetworkProvider();

  Future<ForceUpdateResponse> checkForceUpdate({
    required String appVersion,
  }) async {
    final response = await _tokenProvider.call(
      path: ApiPath.forceUpdate,
      method: RequestMethod.get,
      queryParams: {'appversion': appVersion},
      options: Options(
        headers: ApiHeaders.requestHeader,
      ),
    );

    final res =
    processData((p0) => ForceUpdateResponse.fromJson(p0), response);
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