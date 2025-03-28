import 'package:dio/dio.dart';
import 'package:rex_api/src/endpoints/onboarding/complete_onboard/models/complete_onboard_request.dart';
import 'package:rex_api/src/endpoints/onboarding/complete_onboard/models/complete_onboard_response.dart';
import 'package:rex_api/src/endpoints/onboarding/complete_onboard/models/onboard_business_info.dart';
import 'package:rex_api/src/endpoints/shared_models/api_headers.dart';
import 'package:rex_api/src/exceptions/data_transformer.dart';
import 'package:rex_api/src/exceptions/rex_api_exception.dart';
import 'package:rex_api/src/exceptions/string_constants.dart';
import 'package:rex_api/src/utils/api_path.dart';
import 'package:rex_api/src/utils/dio_network_provider.dart';

mixin CompleteOnboard {
  final tokenProvider = AppNetworkProvider();

  Future<CompleteOnboardResponse> completeOnboard({
    required CompleteOnboardRequest request,
  }) async {
    final apiCall = await tokenProvider.call(
      path: ApiPath.completeOnboard,
      method: RequestMethod.post,
      options: Options(headers: ApiHeaders.requestHeader),
      body: request.toJson(),
    );

    final res = processData(
      (p0) => CompleteOnboardResponse.fromJson(p0),
      apiCall,
    );

    res.either(
      (left) => throw RexApiException(
        message: res.left.message ?? StringConstants.exceptionMessage,
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

  Future<OnboardBusinessInfoResponse> onboardBusinessInfo({
    required String username,
  }) async {
    final apiCall = await tokenProvider.call(
      path: ApiPath.onboardBusinessInfo(username),
      method: RequestMethod.get,
      options: Options(headers: ApiHeaders.requestHeader),
    );

    final res = processData(
      (p0) => OnboardBusinessInfoResponse.fromJson(p0),
      apiCall,
    );

    res.either(
      (left) => throw RexApiException(
        message: res.left.message ?? StringConstants.exceptionMessage2,
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
