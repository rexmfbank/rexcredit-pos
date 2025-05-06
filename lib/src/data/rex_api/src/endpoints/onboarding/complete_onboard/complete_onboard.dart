import 'package:dio/dio.dart';
import 'models/complete_onboard_request.dart';
import 'models/complete_onboard_response.dart';
import 'models/onboard_business_info.dart';
import '../../shared_models/api_headers.dart';
import '../../../exceptions/data_transformer.dart';
import '../../../exceptions/rex_api_exception.dart';
import '../../../exceptions/string_constants.dart';
import '../../../utils/api_path.dart';
import '../../../utils/dio_network_provider.dart';

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
