import 'package:dio/dio.dart';
import 'package:rex_api/src/endpoints/referrals/models/user_referral.dart';
import 'package:rex_api/src/endpoints/shared_models/api_headers.dart';
import 'package:rex_api/src/exceptions/data_transformer.dart';
import 'package:rex_api/src/exceptions/rex_api_exception.dart';
import 'package:rex_api/src/exceptions/string_constants.dart';
import 'package:rex_api/src/utils/api_path.dart';
import 'package:rex_api/src/utils/dio_network_provider.dart';

mixin FetchReferrals {
  final tokenProvider = AppNetworkProvider();

  Future<UserReferral> fetchReferrals({
    required String authToken,
    required String referralCode,
  }) async {
    final apiCall = await tokenProvider.call(
      path: ApiPath.fetchReferrals(referralCode),
      method: RequestMethod.get,
      options: Options(headers: ApiHeaders.requestHeaderWithToken(authToken)),
    );

    final res = processData(
      (p0) => UserReferral.fromJson(p0),
      apiCall,
    );

    res.either(
      (left) => throw RexApiException(
          message: res.left.responseMessage ?? StringConstants.exceptionMessage),
      (right) => tokenProvider.parseResponse(
        responseCode: res.isRight ? res.right.responseCode : '',
        errorAction: () =>
            throw RexApiException(message: res.right.responseMessage),
      ),
    );

    return res.right;
  }
}
