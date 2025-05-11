import 'package:dio/dio.dart';
import '../../shared_models/api_headers.dart';
import 'models/resend_otp_response.dart';
import 'models/send_otp_request.dart';
import '../../utility/request/encrypt_request_template.dart';
import '../../../exceptions/data_transformer.dart';
import '../../../exceptions/rex_api_exception.dart';
import '../../../exceptions/string_constants.dart';
import '../../../utils/api_path.dart';
import '../../../utils/dio_network_provider.dart';
import '../../../utils/encryption_utils.dart';

mixin ResendOtp {
  final tokenProvider = AppNetworkProvider();

  Future<ResendOtpResponse> resendOtp({
    required SendOtpRequest request,
    required String appVersion,
  }) async {
    final apiCall = await tokenProvider.call(
      path: ApiPath.resendOtp,
      method: RequestMethod.post,
      options: Options(headers: ApiHeaders.requestHeaderCrypted(appVersion)),
      body: EncryptRequestTemplate(
        data: EncryptionUtils.encryptToApi(
          request.toJson(),
        ),
      ).toJson(),
    );

    final res = processData(
      (p0) {
        final jsonResponse = EncryptionUtils.decryptFromApi(p0);
        return ResendOtpResponse.fromJson(jsonResponse);
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
