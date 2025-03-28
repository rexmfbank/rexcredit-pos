import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:rex_api/src/endpoints/shared_models/api_headers.dart';
import 'package:rex_api/src/endpoints/user_manager/login/models/requests/login_request.dart';
import 'package:rex_api/src/endpoints/user_manager/login/models/response/login_response.dart';
import 'package:rex_api/src/endpoints/utility/request/encrypt_request_template.dart';
import 'package:rex_api/src/exceptions/data_transformer.dart';
import 'package:rex_api/src/exceptions/error_code.dart';
import 'package:rex_api/src/exceptions/login_exceptions.dart';
import 'package:rex_api/src/exceptions/rex_api_exception.dart';
import 'package:rex_api/src/exceptions/string_constants.dart';
import 'package:rex_api/src/utils/api_path.dart';
import 'package:rex_api/src/utils/dio_network_provider.dart';
import 'package:rex_api/src/utils/encryption_utils.dart';

mixin Login {
  final tokenProvider = AppNetworkProvider();

  Future<LoginResponse> login({
    required String pushId,
    required String appVersion,
    required LoginRequest request,
    required VoidCallback errorAction,
  }) async {
    final apiCall = await tokenProvider.call(
      path: ApiPath.login,
      method: RequestMethod.post,
      options: Options(
          headers: ApiHeaders.loginRequestHeader(
        pushId,
        xAppVersion: appVersion,
      )),
      body: EncryptRequestTemplate(
        data: EncryptionUtils.encryptToApi(request.toJson()),
      ).toJson(),
    );

    final res = processData(
      (p0) {
        final jsonResponse = EncryptionUtils.decryptFromApi(p0);
        return LoginResponse.fromJson(jsonResponse);
      },
      apiCall,
    );

    res.either(
      (left) {
        throw RexApiException(
          message: res.left.message ?? StringConstants.exceptionMessage2,
        );
      },
      (right) => tokenProvider.parseResponse(
        responseCode: res.isRight ? res.right.responseCode : '',
        errorAction: () {
          if (res.right.responseCode == ErrorCode.COMPLETE_2ND_ONBOARDING) {
            throw CompleteSecondOnboardException(res.right.responseMessage);
          } else if (res.right.responseCode ==
              ErrorCode.COMPLETE_OTP_VERIFICATION) {
            throw CompleteVerifyOTPException(res.right.responseMessage);
          } else if (res.right.responseCode ==
              ErrorCode.COMPLETE_TRANSACTION_PIN) {
            throw CompleteTransactionPINException(res.right.responseMessage);
          } else if (res.right.responseCode == ErrorCode.INVALID_DEVICE) {
            throw InvalidDeviceException(res.right.responseMessage);
          } else if (res.right.responseCode ==
              ErrorCode.COMPLETE_BUSINESS_INFO) {
            throw CompleteBusinessInfoException(res.right.responseMessage);
          } else if (res.right.responseCode ==
              ErrorCode.COMPLETE_BUSINESS_DOCS) {
            throw CompleteBusinessDocsException(res.right.responseMessage);
          } else if (res.right.responseCode ==
              ErrorCode.COMPLETE_BUSINESS_DIRECTORS) {
            throw CompleteBusinessDirectorsException(res.right.responseMessage);
          } else {
            throw RexApiException(message: res.right.responseMessage);
          }
        },
      ),
    );

    return res.right;
  }
}
