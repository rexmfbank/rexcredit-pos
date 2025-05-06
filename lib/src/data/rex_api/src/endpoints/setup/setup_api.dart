import 'package:dio/dio.dart';
import 'response/force_update_response.dart';
import '../shared_models/api_headers.dart';
import '../../exceptions/data_transformer.dart';
import '../../exceptions/rex_api_exception.dart';
import '../../exceptions/string_constants.dart';
import '../../utils/api_path.dart';
import '../../utils/dio_network_provider.dart';

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