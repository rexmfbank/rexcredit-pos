import 'package:dio/dio.dart';
import 'models/acount_topup_request.dart';
import 'models/acount_topup_response.dart';
import '../../shared_models/api_headers.dart';
import '../../utility/request/encrypt_request_template.dart';
import '../../../exceptions/data_transformer.dart';
import '../../../exceptions/rex_api_exception.dart';
import '../../../exceptions/string_constants.dart';
import '../../../utils/api_path.dart';
import '../../../utils/dio_network_provider.dart';
import '../../../utils/encryption_utils.dart';

mixin AccountTopUp {
  static final _tokenProvider = AppNetworkProvider();

  Future<AccountTopUpResponse> accountTopUp({
    required String authToken,
    required String appVersion,
    required AccountTopUpRequest request,
  }) async {
    final cryptRequest = EncryptionUtils.encryptToApi(request.toJson());

    final response = await _tokenProvider.call(
      path: ApiPath.topUpV2,
      method: RequestMethod.post,
      body: EncryptRequestTemplate(
        data: EncryptionUtils.encryptToApi(request.toJson()),
      ).toJson(),
      options: Options(
        headers: ApiHeaders.encryptedTransactionRequestHeaderToken(
          authToken,
          xAppVersion: appVersion,
        ),
      ),
    );

    final res = processData(
      (p0) {
        final jsonResponse = EncryptionUtils.decryptFromApi(p0);
        return AccountTopUpResponse.fromJson(jsonResponse);
      },
      response,
    );

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
