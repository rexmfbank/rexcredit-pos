import 'package:dio/dio.dart';
import 'package:rex_app/src/modules/revamp/data/rex_api/rex_api.dart';
import '../../shared_models/api_headers.dart';
import '../../utility/request/encrypt_request_template.dart';
import '../../../exceptions/data_transformer.dart';
import '../../../exceptions/rex_api_exception.dart';
import '../../../exceptions/string_constants.dart';
import '../../../utils/api_path.dart';
import '../../../utils/dio_network_provider.dart';
import '../../../utils/encryption_utils.dart';

mixin InitiatePasswordReset {
  Future<InitiatePasswordResetResponse> initiatePasswordReset({
    required String username,
    required String entityCode,
    required String appVersion,
  }) async {
    final tokenProvider = AppNetworkProvider();

    final request = InitiatePasswordResetRequest(
        entityCode: entityCode, username: username);
    final cryptRequest = EncryptionUtils.encryptToApi(request.toJson());

    final apiCall = await tokenProvider.call(
      path: ApiPath.initiatePasswordResetV2,
      method: RequestMethod.post,
      body: EncryptRequestTemplate(data: cryptRequest).toJson(),
      options: Options(headers: ApiHeaders.requestHeaderCrypted(appVersion)),
    );

    final res = processData(
      (p0) {
        final jsonResponse = EncryptionUtils.decryptFromApi(p0);
        return InitiatePasswordResetResponse.fromJson(jsonResponse);
      },
      apiCall,
    );

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
