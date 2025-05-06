import 'package:dio/dio.dart';
import 'model/create_deposit_request.dart';
import 'model/create_deposit_response.dart';
import 'model/deposit_duration.dart';
import 'model/deposit_interest_rate_request.dart';
import 'model/deposit_interest_rate_response.dart';
import 'model/deposit_interest_type.dart';
import 'model/deposit_list.dart';
import 'model/deposit_wallet_balance.dart';
import '../shared_models/api_headers.dart';
import '../utility/request/encrypt_request_template.dart';
import '../../exceptions/data_transformer.dart';
import '../../exceptions/rex_api_exception.dart';
import '../../exceptions/string_constants.dart';
import '../../utils/api_path.dart';
import '../../utils/dio_network_provider.dart';
import '../../utils/encryption_utils.dart';

mixin FixedDepositApi {
  final tokenProvider = AppNetworkProvider();

  /// get interest rate for fixed deposit
  Future<DepositInterestRateResponse> depositInterestRate({
    required String authToken,
    required String appVersion,
    required String deviceId,
    required DepositInterestRateRequest request,
  }) async {
    final apiCall = await tokenProvider.call(
      path: ApiPath.depositInterestRate,
      method: RequestMethod.post,
      body: EncryptRequestTemplate(
        data: EncryptionUtils.encryptToApi(request.toJson()),
      ).toJson(),
      options: Options(
        headers: ApiHeaders.encryptedTransactionRequestHeaderToken(
          authToken,
          xAppVersion: appVersion,
          xDeviceId: deviceId,
        ),
      ),
    );

    final res = processData(
      (p0) {
        final jsonResponse = EncryptionUtils.decryptFromApi(p0);
        return DepositInterestRateResponse.fromJson(jsonResponse);
      },
      apiCall,
    );

    res.either(
      (left) => throw RexApiException(
          message: res.left.responseMessage ?? StringConstants.exceptionMessage),
      (right) => tokenProvider.parseResponse(
        responseCode: res.isRight ? res.right.responseCode : '',
        errorAction: () =>
            throw RexApiException(message: res.right.responseMessage),
      ),
    );

    return res.right;
  }

  /// create fixed deposit
  Future<CreateDepositResponse> depositCreation({
    required String authToken,
    required String appVersion,
    required String transactionPin,
    required String deviceId,
    required CreateDepositRequest request,
  }) async {
    final apiCall = await tokenProvider.call(
      path: ApiPath.depositCreate,
      method: RequestMethod.post,
      body: EncryptRequestTemplate(
        data: EncryptionUtils.encryptToApi(request.toJson()),
      ).toJson(),
      options: Options(
        headers: ApiHeaders.encryptedTransactionRequestHeaderToken(
          authToken,
          xAppVersion: appVersion,
          xDeviceId: deviceId,
          transactionPin: transactionPin,
        ),
      ),
    );

    final res = processData(
      (p0) {
        final jsonResponse = EncryptionUtils.decryptFromApi(p0);
        return CreateDepositResponse.fromJson(jsonResponse);
      },
      apiCall,
    );

    res.either(
      (left) => throw RexApiException(
          message: res.left.responseMessage ?? StringConstants.exceptionMessage),
      (right) => tokenProvider.parseResponse(
        responseCode: res.isRight ? res.right.responseCode : '',
        errorAction: () =>
            throw RexApiException(message: res.right.responseMessage),
      ),
    );
    return res.right;
  }

  /// get list of fixed deposit interest type
  Future<DepositInterestType> depositInterestType({
    required String authToken,
    required String appVersion,
    required String deviceId,
    required String countryCode,
  }) async {
    final apiCall = await tokenProvider.call(
      path: ApiPath.depositInterestType,
      method: RequestMethod.post, // formerly GET with request-param
      body: EncryptRequestTemplate(
        data: EncryptionUtils.encryptToApi({"countryCode": countryCode}),
      ).toJson(),
      options: Options(
        headers: ApiHeaders.encryptedTransactionRequestHeaderToken(
          authToken,
          xAppVersion: appVersion,
          xDeviceId: deviceId,
        ),
      ),
    );

    final res = processData(
      (p0) {
        final jsonResponse = EncryptionUtils.decryptFromApi(p0);
        return DepositInterestType.fromJson(jsonResponse);
      },
      apiCall,
    );

    res.either(
      (left) => throw RexApiException(
          message: res.left.responseMessage ?? StringConstants.exceptionMessage),
      (right) => tokenProvider.parseResponse(
        responseCode: res.isRight ? res.right.responseCode : '',
        errorAction: () =>
            throw RexApiException(message: res.right.responseMessage),
      ),
    );
    return res.right;
  }

  /// get list of fixed deposit duration
  Future<DepositDuration> depositDuration({
    required String authToken,
    required String appVersion,
    required String deviceId,
  }) async {
    final apiCall = await tokenProvider.call(
      path: ApiPath.depositDuration,
      method: RequestMethod.get,
      options: Options(
        headers: ApiHeaders.encryptedTransactionRequestHeaderToken(
          authToken,
          xAppVersion: appVersion,
          xDeviceId: deviceId,
        ),
      ),
    );

    final res = processData(
      (p0) {
        final jsonResponse = EncryptionUtils.decryptFromApi(p0);
        return DepositDuration.fromJson(jsonResponse);
      },
      apiCall,
    );

    res.either(
      (left) => throw RexApiException(
          message: res.left.responseMessage ?? StringConstants.exceptionMessage),
      (right) => tokenProvider.parseResponse(
        responseCode: res.isRight ? res.right.responseCode : '',
        errorAction: () =>
            throw RexApiException(message: res.right.responseMessage),
      ),
    );

    return res.right;
  }

  /// get list of fixed deposits for a user
  Future<DepositList> depositList({
    required String authToken,
    required String appVersion,
    required String deviceId,
  }) async {
    final apiCall = await tokenProvider.call(
      path: ApiPath.depositList,
      method: RequestMethod.get,
      options: Options(
        headers: ApiHeaders.encryptedTransactionRequestHeaderToken(
          authToken,
          xAppVersion: appVersion,
          xDeviceId: deviceId,
        ),
      ),
    );

    final res = processData(
      (p0) {
        final jsonResponse = EncryptionUtils.decryptFromApi(p0);
        return DepositList.fromJson(jsonResponse);
      },
      apiCall,
    );

    res.either(
      (left) => throw RexApiException(
          message: res.left.responseMessage ?? StringConstants.exceptionMessage),
      (right) => tokenProvider.parseResponse(
        responseCode: res.isRight ? res.right.responseCode : '',
        errorAction: () =>
            throw RexApiException(message: res.right.responseMessage),
      ),
    );
    return res.right;
  }

  /// get the total amount in a the fixed deposit wallet of a user
  Future<FixedDepositWalletBalance> depositWallet({
    required String authToken,
    required String appVersion,
    required String deviceId,
  }) async {
    final apiCall = await tokenProvider.call(
      path: ApiPath.depositTotalAmount,
      method: RequestMethod.get,
      options: Options(
        headers: ApiHeaders.encryptedTransactionRequestHeaderToken(
          authToken,
          xAppVersion: appVersion,
          xDeviceId: deviceId,
        ),
      ),
    );

    final res = processData(
      (p0) {
        final jsonResponse = EncryptionUtils.decryptFromApi(p0);
        return FixedDepositWalletBalance.fromJson(jsonResponse);
      },
      apiCall,
    );

    res.either(
      (left) => throw RexApiException(
          message: res.left.responseMessage ?? StringConstants.exceptionMessage),
      (right) => tokenProvider.parseResponse(
        responseCode: res.isRight ? res.right.responseCode : '',
        errorAction: () =>
            throw RexApiException(message: res.right.responseMessage),
      ),
    );
    return res.right;
  }
}
