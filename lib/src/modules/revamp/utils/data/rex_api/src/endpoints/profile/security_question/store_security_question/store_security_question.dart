import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:rex_app/src/modules/revamp/utils/data/rex_api/rex_api.dart';
import 'package:rex_app/src/modules/revamp/utils/data/rex_api/src/endpoints/profile/set_withdrawal_limit_response.dart';
import 'package:rex_app/src/modules/revamp/utils/data/rex_api/src/exceptions/data_transformer.dart';
import 'package:rex_app/src/modules/revamp/utils/data/rex_api/src/exceptions/string_constants.dart';
import 'package:rex_app/src/modules/revamp/utils/data/rex_api/src/utils/dio_network_provider.dart';
import '../../../shared_models/api_headers.dart';
import '../../../../exceptions/error_code.dart';
import '../../../../exceptions/rex_api_exception.dart';
import '../../../../utils/api_path.dart';

mixin StoreSecurityQuestion {
  static final _tokenProvider = AppNetworkProvider();

  Future<StoreSecurityQuestionResponse> storeSecurityQuestion({
    required String token,
    required StoreSecurityQuestionRequest request,
  }) async {
    try {
      final dio =
          Dio()
            ..interceptors.add(
              PrettyDioLogger(
                requestHeader: true,
                requestBody: true,
                responseBody: true,
                compact: false,
              ),
            );
      final response = await dio.post(
        ApiPath.saveSecurityQuestion,
        data: request.toJson(),
        options: Options(
          headers: ApiHeaders.transactionRequestHeaderToken(token),
        ),
      );
      var apiResponse = StoreSecurityQuestionResponse.fromJson(response.data);
      if (apiResponse.responseCode == ErrorCode.SUCCESS) {
        return StoreSecurityQuestionResponse.fromJson(response.data);
      }

      throw RexApiException(responseMessage: apiResponse.responseMessage);
    } on DioException catch (e, stackTrace) {
      final rexException = RexApiException.defaultMessage();
      if (e.response == null) throw rexException;
      if (e.response!.data == null) throw rexException;
      print("Error Stack => $stackTrace");

      final errorJson = ErrorData.fromJson(e.response!.data);
      throw RexApiException(message: errorJson.responseMessage);
    } catch (e, stackTrace) {
      print("Error => ${e.toString()}");
      print("Error Stack => $stackTrace");
      throw RexApiException.defaultMessage();
    }
  }

  Future<SetWithdrawalLimitResponse> validateTransactionPIN({
    required String authToken,
    required String transactionPin,
    required String deviceId,
    required String userName,
  }) async {
    final response = await _tokenProvider.call(
      path: ApiPath.validateTransactionPin,
      method: RequestMethod.post,
      body: {
        "userPin": transactionPin,
        "deviceId": deviceId,
        "username": userName,
      },
      options: Options(headers: ApiHeaders.requestHeaderWithToken(authToken)),
    );

    final res = processData(
      (p0) => SetWithdrawalLimitResponse.fromJson(p0),
      response,
    );
    res.either(
      (left) =>
          throw RexApiException(
            message:
                res.left.responseMessage ?? StringConstants.exceptionMessage,
          ),
      (right) => _tokenProvider.parseResponse(
        responseCode: res.isRight ? res.right.responseCode : '',
        errorAction: () {
          if (res.right.responseCode == ErrorCode.ACCOUNT_LOCK_PIN) {
            throw AccountLockException(res.right.responseMessage);
          } else {
            throw RexApiException(message: res.right.responseMessage);
          }
        },
      ),
    );

    return res.right;
  }
}
