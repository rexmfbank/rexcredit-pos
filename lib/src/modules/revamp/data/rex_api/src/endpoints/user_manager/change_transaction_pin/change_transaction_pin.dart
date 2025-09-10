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

mixin ChangeTransactionPin {
  Future<ChangePinResponse> changeTransactionPin({
    required String authToken,
    required String appVersion,
    required ChangePinRequest request,
  }) async {
    final tokenProvider = AppNetworkProvider();

    final cryptRequest = EncryptionUtils.encryptToApi(request.toJson());

    final apiCall = await tokenProvider.call(
      path: ApiPath.changeTransactionPINV2,
      method: RequestMethod.post,
      options: Options(
          headers: ApiHeaders.encryptedTransactionRequestHeaderToken(
        authToken,
        xAppVersion: appVersion,
      )),
      body: EncryptRequestTemplate(data: cryptRequest).toJson(),
    );

    final res = processData(
      (p0) {
        final jsonResponse = EncryptionUtils.decryptFromApi(p0);
        return ChangePinResponse.fromJson(jsonResponse);
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
