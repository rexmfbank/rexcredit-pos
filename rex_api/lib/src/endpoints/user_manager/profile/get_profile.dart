import 'package:dio/dio.dart';
import 'package:rex_api/src/endpoints/shared_models/api_headers.dart';
import 'package:rex_api/src/endpoints/user_manager/profile/models/customer_tier_response.dart';
import 'package:rex_api/src/endpoints/user_manager/profile/models/get_profile_response.dart';
import 'package:rex_api/src/exceptions/data_transformer.dart';
import 'package:rex_api/src/exceptions/rex_api_exception.dart';
import 'package:rex_api/src/exceptions/string_constants.dart';
import 'package:rex_api/src/utils/api_path.dart';
import 'package:rex_api/src/utils/dio_network_provider.dart';

mixin GetProfileInfo {
  static final _tokenProvider = AppNetworkProvider();

  Future<GetProfileResponse> getProfileInfo({
    required String token,
  }) async {
    final response = await _tokenProvider.call(
      path: ApiPath.getProfile,
      method: RequestMethod.get,
      options: Options(
        headers: ApiHeaders.requestHeaderWithToken(token),
      ),
    );

    final res = processData((p0) => GetProfileResponse.fromJson(p0), response);
    res.either(
      (left) => throw RexApiException(
        message: res.left.responseMessage ?? StringConstants.exceptionMessage2,
      ),
      (right) => _tokenProvider.parseResponse(
        responseCode: res.isRight ? res.right.responseCode : '',
        errorAction: () =>
            throw RexApiException(message: res.right.responseMessage),
      ),
    );

    return res.right;
  }

  Future<CustomerTierResponse> getCustomerAccountLimit({
    required String token,
  }) async {
    final response = await _tokenProvider.call(
      path: ApiPath.customerLimit,
      method: RequestMethod.get,
      options: Options(headers: ApiHeaders.requestHeaderWithToken(token)),
    );

    final res = processData(
      (p0) => CustomerTierResponse.fromJson(p0),
      response,
    );

    res.either(
      (left) => throw RexApiException(
        message: res.left.responseMessage ?? StringConstants.exceptionMessage2,
      ),
      (right) => _tokenProvider.parseResponse(
        responseCode: res.isRight ? res.right.responseCode : '',
        errorAction: () => throw RexApiException(
          message: res.right.responseMessage,
        ),
      ),
    );

    return res.right;
  }
}
