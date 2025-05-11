import 'package:dio/dio.dart';
import 'package:rex_app/src/data/rex_api/rex_api.dart';
import '../../shared_models/api_headers.dart';
import '../../utility/request/encrypt_request_template.dart';
import '../../../exceptions/data_transformer.dart';
import '../../../exceptions/rex_api_exception.dart';
import '../../../exceptions/string_constants.dart';
import '../../../utils/api_path.dart';
import '../../../utils/dio_network_provider.dart';
import '../../../utils/encryption_utils.dart';

mixin InternalTransfer {
  static final _tokenProvider = AppNetworkProvider();

  Future<InternalTransferResponse> performInternalTransfer(
      {required String token,
      required String appVersion,
      required InternalTransferRequest request,
      required String transactionPin}) async {
    final response = await _tokenProvider.call(
      path: ApiPath.internalTransferV2,
      method: RequestMethod.post,
      body: EncryptRequestTemplate(
        data: EncryptionUtils.encryptToApi(
          request.toJson(),
        ),
      ).toJson(),
      options: Options(
        headers: ApiHeaders.encryptedTransactionRequestHeaderToken(
          token,
          xAppVersion: appVersion,
          transactionPin: transactionPin,
        ),
      ),
    );

    final res = processData(
      (p0) {
        final jsonResponse = EncryptionUtils.decryptFromApi(p0);
        print(jsonResponse);
        return InternalTransferResponse.fromJson(jsonResponse);
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
