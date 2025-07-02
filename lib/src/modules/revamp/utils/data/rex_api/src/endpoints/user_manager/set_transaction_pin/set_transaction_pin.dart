import 'package:dio/dio.dart';
import '../../shared_models/api_headers.dart';
import 'models/set_transaction_pin_request.dart';
import 'models/set_transaction_pin_response.dart';
import '../../utility/request/encrypt_request_template.dart';
import '../../../exceptions/data_transformer.dart';
import '../../../exceptions/rex_api_exception.dart';
import '../../../exceptions/string_constants.dart';
import '../../../utils/api_path.dart';
import '../../../utils/dio_network_provider.dart';
import '../../../utils/encryption_utils.dart';

mixin SetTransactionPin {
  Future<SetTransactionPinResponse> setTransactionPin({
    required String appVersion,
    required SetTransactionPinRequest request,
  }) async {
    final tokenProvider = AppNetworkProvider();
    final cryptRequest = EncryptionUtils.encryptToApi(request.toJson());

    final apiCall = await tokenProvider.call(
      path: ApiPath.setTransactionPinV2,
      method: RequestMethod.post,
      options: Options(headers: ApiHeaders.requestHeaderCrypted(appVersion)),
      body: EncryptRequestTemplate(data: cryptRequest).toJson(),
    );

    final res = processData(
      (p0) {
        final jsonResponse = EncryptionUtils.decryptFromApi(p0);
        return SetTransactionPinResponse.fromJson(jsonResponse);
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
