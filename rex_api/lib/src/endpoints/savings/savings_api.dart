import 'package:dio/dio.dart';
import 'package:rex_api/src/endpoints/savings/model/create_saving_request.dart';
import 'package:rex_api/src/endpoints/savings/model/create_saving_response.dart';
import 'package:rex_api/src/endpoints/savings/model/fetch_target_savings_response.dart';
import 'package:rex_api/src/endpoints/savings/model/fund_saving_request.dart';
import 'package:rex_api/src/endpoints/savings/model/fund_saving_response.dart';
import 'package:rex_api/src/endpoints/savings/model/savings_return_request.dart';
import 'package:rex_api/src/endpoints/savings/model/savings_return_response.dart';
import 'package:rex_api/src/endpoints/savings/model/savings_transaction_response.dart';
import 'package:rex_api/src/endpoints/savings/model/savings_wallet_balance.dart';
import 'package:rex_api/src/endpoints/shared_models/api_headers.dart';
import 'package:rex_api/src/exceptions/data_transformer.dart';
import 'package:rex_api/src/exceptions/rex_api_exception.dart';
import 'package:rex_api/src/exceptions/string_constants.dart';
import 'package:rex_api/src/utils/api_path.dart';
import 'package:rex_api/src/utils/dio_network_provider.dart';

mixin SavingsApi {
  final tokenProvider = AppNetworkProvider();

  /// create target savings
  Future<CreateSavingsResponse> createTargetSavings({
    required String authToken,
    required String transactionPin,
    required String deviceId,
    required CreateSavingRequest request,
  }) async {
    final apiCall = await tokenProvider.call(
      path: ApiPath.savingsCreate,
      method: RequestMethod.post,
      options: Options(
        headers: ApiHeaders.transactionRequestHeaderToken(
          authToken,
          xDeviceId: deviceId,
          transactionPin: transactionPin,
        ),
      ),
      body: request.toJson(),
    );

    final res = processData(
      (p0) => CreateSavingsResponse.fromJson(p0),
      apiCall,
    );

    res.either(
      (left) => throw RexApiException(
          message:
              res.left.responseMessage ?? StringConstants.exceptionMessage),
      (right) => tokenProvider.parseResponse(
        responseCode: res.isRight ? res.right.responseCode : '',
        errorAction: () =>
            throw RexApiException(message: res.right.responseMessage),
      ),
    );
    return res.right;
  }

  /// calculate savings return
  Future<SavingsReturnResponse> calculateReturn({
    required String authToken,
    required String deviceId,
    required SavingsReturnRequest request,
  }) async {
    final apiCall = await tokenProvider.call(
      path: ApiPath.savingsReturn,
      method: RequestMethod.post,
      body: request.toJson(),
      options: Options(
        headers: ApiHeaders.transactionRequestHeaderToken(
          authToken,
          xDeviceId: deviceId,
        ),
      ),
    );

    final res = processData(
      (p0) => SavingsReturnResponse.fromJson(p0),
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

  /// fetch list of target savings
  Future<FetchTargetSavingsResponse> fetchTargetSavings({
    required String authToken,
    required String deviceId,
  }) async {
    final apiCall = await tokenProvider.call(
      path: ApiPath.savingsList,
      method: RequestMethod.get,
      options: Options(
        headers: ApiHeaders.transactionRequestHeaderToken(
          authToken,
          xDeviceId: deviceId,
        ),
      ),
    );

    final res = processData(
      (p0) => FetchTargetSavingsResponse.fromJson(p0),
      apiCall,
    );

    res.either(
      (left) => throw RexApiException(
        message: res.left.message ?? StringConstants.exceptionMessage,
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

  /// fund target savings
  Future<FundSavingResponse> fundTargetSavings({
    required String authToken,
    required String deviceId,
    required int savingId,
    required FundSavingRequest request,
  }) async {
    final apiCall = await tokenProvider.call(
      path: ApiPath.savingsFunding(savingId),
      method: RequestMethod.post,
      body: request.toJson(),
      options: Options(
        headers: ApiHeaders.transactionRequestHeaderToken(
          authToken,
          xDeviceId: deviceId,
        ),
      ),
    );

    final res = processData(
      (p0) => FundSavingResponse.fromJson(p0),
      apiCall,
    );

    res.either(
      (left) => throw RexApiException(
        message: res.left.message ?? StringConstants.exceptionMessage,
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

  /// get balance on savings wallet
  Future<SavingsWalletBalance> getSavingsWallet({
    required String authToken,
    required String deviceId,
  }) async {
    final apiCall = await tokenProvider.call(
      path: ApiPath.savingsTotalAmount,
      method: RequestMethod.get,
      options: Options(
        headers: ApiHeaders.transactionRequestHeaderToken(
          authToken,
          xDeviceId: deviceId,
        ),
      ),
    );

    final res = processData(
      (p0) => SavingsWalletBalance.fromJson(p0),
      apiCall,
    );

    res.either(
      (left) => throw RexApiException(
        message: res.left.message ?? StringConstants.exceptionMessage,
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

  /// get recent transactions on savings wallet
  Future<SavingsTransactionResponse> getSavingsTransaction({
    required String authToken,
    required String deviceId,
    required int pageNumber,
    required int pageSize,
  }) async {
    final apiCall = await tokenProvider.call(
      path: ApiPath.savingsRecentTransaction(pageNumber, pageSize),
      method: RequestMethod.get,
      options: Options(
        headers: ApiHeaders.transactionRequestHeaderToken(
          authToken,
          xDeviceId: deviceId,
        ),
      ),
    );

    final res = processData(
      (p0) => SavingsTransactionResponse.fromJson(p0),
      apiCall,
    );

    res.either(
      (left) => throw RexApiException(
        message: res.left.message ?? StringConstants.exceptionMessage,
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
