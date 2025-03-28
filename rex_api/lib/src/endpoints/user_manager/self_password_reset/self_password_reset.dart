import 'package:dio/dio.dart';
import 'package:rex_api/src/endpoints/shared_models/api_headers.dart';
import 'package:rex_api/src/endpoints/user_manager/self_password_reset/models/self_password_reset_request.dart';
import 'package:rex_api/src/endpoints/user_manager/self_password_reset/models/self_password_reset_response.dart';
import 'package:rex_api/src/endpoints/utility/request/encrypt_request_template.dart';
import 'package:rex_api/src/exceptions/data_transformer.dart';
import 'package:rex_api/src/exceptions/rex_api_exception.dart';
import 'package:rex_api/src/exceptions/string_constants.dart';
import 'package:rex_api/src/utils/api_path.dart';
import 'package:rex_api/src/utils/dio_network_provider.dart';
import 'package:rex_api/src/utils/encryption_utils.dart';

mixin SelfPasswordReset {
  Future<SelfPasswordResetResponse> selfPasswordReset({
    required String appVersion,
    required SelfPasswordResetRequest request,
  }) async {
    final tokenProvider = AppNetworkProvider();
    final cryptRequest = EncryptionUtils.encryptToApi(request.toJson());

    final apiCall = await tokenProvider.call(
      path: ApiPath.selfPasswordResetV2,
      method: RequestMethod.post,
      options: Options(headers: ApiHeaders.requestHeaderCrypted(appVersion)),
      body: EncryptRequestTemplate(data: cryptRequest).toJson(),
    );

    final res = processData((p0) {
      final jsonResponse = EncryptionUtils.decryptFromApi(p0);
      return SelfPasswordResetResponse.fromJson(jsonResponse);
    }, apiCall);

    res.either(
      (left) => throw RexApiException(
        message: res.left.responseMessage ?? StringConstants.exceptionMessage,
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
