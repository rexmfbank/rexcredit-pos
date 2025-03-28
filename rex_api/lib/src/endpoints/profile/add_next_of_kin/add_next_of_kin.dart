import 'package:dio/dio.dart';
import 'package:rex_api/rex_api.dart';
import 'package:rex_api/src/exceptions/data_transformer.dart';
import 'package:rex_api/src/utils/api_path.dart';
import 'package:rex_api/src/utils/dio_network_provider.dart';
import 'package:rex_api/src/exceptions/string_constants.dart';

import '../../../exceptions/rex_api_exception.dart';
import '../../shared_models/api_headers.dart';

mixin AddNextOfKin {
  static final _tokenProvider = AppNetworkProvider();

  Future<AddNextOfKinResponse> addNextOfKin({
      required String authToken,
      required AddNextOfKinRequest request,
    }) async {
    final response = await _tokenProvider.call(
      path: ApiPath.addNextOfKin,
      method: RequestMethod.post,
      body: request.toJson(),
      options: Options(
        headers: ApiHeaders.requestHeaderWithToken(authToken),
      ),
    );

    final res = processData((p0) => AddNextOfKinResponse.fromJson(p0), response);
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
