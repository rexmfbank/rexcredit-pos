import 'package:dio/dio.dart';
import 'package:rex_app/src/data/rex_api/rex_api.dart';
import '../../shared_models/api_headers.dart';
import '../../../exceptions/rex_api_exception.dart';
import '../../../exceptions/string_constants.dart';
import '../../../utils/api_path.dart';

import '../../../exceptions/data_transformer.dart';
import '../../../utils/dio_network_provider.dart';

mixin FetchBeneficiaries {
  static final _tokenProvider = AppNetworkProvider();

  Future<FetchBeneficiaryResponse> fetchBeneficiaries({
    required String authToken,
    required String accountNo,
    required String transCode,
  }) async {
    final response = await _tokenProvider.call(
      path: ApiPath.fetchBeneficiary,
      method: RequestMethod.get,
      queryParams: {'accountNo': accountNo, 'transCode': transCode},
      options: Options(
        headers: ApiHeaders.requestHeaderWithToken(authToken),
      ),
    );

    final res =
        processData((p0) => FetchBeneficiaryResponse.fromJson(p0), response);
    res.either(
      (left) => throw RexApiException(
          message:
              res.left.responseMessage ?? StringConstants.exceptionMessage),
      (right) => _tokenProvider.parseResponse(
        responseCode: res.isRight ? res.right.responseCode : '',
        errorAction: () =>
            throw RexApiException(message: res.right.responseMessage),
      ),
    );

    return res.right;
  }

  Future<FetchBeneficiaryResponse> searchBeneficiaries({
    required String authToken,
    required SearchBeneficiaryQuery query,
  }) async {
    final response = await _tokenProvider.call(
      path: ApiPath.searchBeneficiary,
      method: RequestMethod.get,
      queryParams: query.toJson(),
      options: Options(
        headers: ApiHeaders.requestHeaderWithToken(authToken),
      ),
    );

    final res =
        processData((p0) => FetchBeneficiaryResponse.fromJson(p0), response);
    res.either(
      (left) => throw RexApiException(
          message:
              res.left.responseMessage ?? StringConstants.exceptionMessage),
      (right) => _tokenProvider.parseResponse(
        responseCode: res.isRight ? res.right.responseCode : '',
        errorAction: () =>
            throw RexApiException(message: res.right.responseMessage),
      ),
    );

    return res.right;
  }
}
