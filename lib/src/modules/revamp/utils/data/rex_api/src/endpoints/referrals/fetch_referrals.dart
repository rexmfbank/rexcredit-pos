import 'package:dio/dio.dart';
import 'models/user_referral.dart';
import '../shared_models/api_headers.dart';
import '../../exceptions/data_transformer.dart';
import '../../exceptions/rex_api_exception.dart';
import '../../exceptions/string_constants.dart';
import '../../utils/api_path.dart';
import '../../utils/dio_network_provider.dart';

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
