import 'package:dio/dio.dart';
import 'package:rex_api/rex_api.dart';
import 'package:rex_api/src/endpoints/shared_models/api_headers.dart';
import 'package:rex_api/src/exceptions/rex_api_exception.dart';
import 'package:rex_api/src/exceptions/string_constants.dart';
import 'package:rex_api/src/utils/api_path.dart';

import '../../../exceptions/data_transformer.dart';
import '../../../utils/dio_network_provider.dart';

mixin SaveBeneficiary {
  static final _tokenProvider = AppNetworkProvider();

  Future<SaveBeneficiaryResponse> saveBeneficiary({
    required String authToken,
    required SaveBeneficiaryRequest request,
  }) async {
    final response = await _tokenProvider.call(
      path: ApiPath.saveBeneficiary,
      method: RequestMethod.post,
      body: request.toJson(),
      options: Options(
        headers: ApiHeaders.requestHeaderWithToken(authToken),
      ),
    );

    final res =
    processData((p0) => SaveBeneficiaryResponse.fromJson(p0), response);
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
