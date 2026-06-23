import 'package:dio/dio.dart';
import 'package:rex_app/src/modules/api/rex_api.dart';
import 'package:rex_app/src/modules/api/dio/api_headers.dart';
import 'package:rex_app/src/modules/api/dio/data_transformer.dart';
import 'package:rex_app/src/modules/api/exceptions/rex_api_exception.dart';
import 'package:rex_app/src/modules/api/exceptions/string_constants.dart';
import 'package:rex_app/src/modules/api/dio/api_path.dart';
import 'package:rex_app/src/modules/api/dio/dio_network_provider.dart';
import 'package:rex_app/src/modules/utils/general/app_functions.dart';

mixin PosEndpoints {
  final tokenProvider = AppNetworkProvider();

  Future<PosAuthResponse> posAuthentication({
    required HeaderNoAuthNoCrypt header,
  }) async {
    final apiCall = await tokenProvider.call(
      path: ApiPath.posAuth(header.deviceID),
      method: RequestMethod.get,
      options: Options(headers: ApiHeaders.noAuthNoCrypt(header)),
    );

    apiCall.either(
      (left) => debugPrintDev('RAW ERROR - POS AUTH: ${left.message}'),
      (right) => debugPrintDev('RAW RESPONSE - POS AUTH: ${right?.data}'),
    );

    final res = processData((p0) {
      return PosAuthResponse.fromJson(p0);
    }, apiCall);

    res.either(
      (left) =>
          throw RexApiException(
            message:
                res.left.responseMessage ?? StringConstants.exceptionMessage,
          ),
      (right) => tokenProvider.parseResponse(
        responseCode: res.isRight ? res.right.responseCode : '',
        errorAction:
            () => throw RexApiException(message: res.right.responseMessage),
      ),
    );
    return res.right;
  }

  Future<PosQuickPurchaseResponse> posQuickPurchase({
    required HeaderWithAuthNoCrypt header,
    required PosQuickPurchaseRequest request,
  }) async {
    final apiCall = await tokenProvider.call(
      path: ApiPath.posQuickPurchase,
      method: RequestMethod.post,
      body: request.toJson(),
      options: Options(headers: ApiHeaders.withAuthNoCrypt(header)),
    );

    apiCall.either(
      (left) => debugPrintDev('RAW ERROR - QUICK PURCHASE: ${left.message}'),
      (right) => debugPrintDev('RAW RESPONSE - QUICK PURCHASE: ${right?.data}'),
    );

    final res = processData((p0) {
      return PosQuickPurchaseResponse.fromJson(p0);
    }, apiCall);

    res.either(
      (left) =>
          throw RexApiException(
            message:
                res.left.responseMessage ?? StringConstants.exceptionMessage,
          ),
      (right) => tokenProvider.parseResponse(
        responseCode: res.isRight ? res.right.responseCode : '',
        errorAction:
            () => throw RexApiException(message: res.right.responseMessage),
      ),
    );
    return res.right;
  }

  Future<PosNfcResponse> posNfcPurchase({
    required HeaderWithAuthNoCrypt header,
    required PosNfcRequest request,
  }) async {
    final apiCall = await tokenProvider.call(
      path: ApiPath.posNfcPurchase,
      method: RequestMethod.post,
      body: request.toJson(),
      options: Options(headers: ApiHeaders.withAuthNoCrypt(header)),
    );

    apiCall.either(
      (left) => debugPrintDev('RAW ERROR - NFC PURCHASE: ${left.message}'),
      (right) => debugPrintDev('RAW RESPONSE - NFC PURCHASE: ${right?.data}'),
    );

    final res = processData((p0) {
      return PosNfcResponse.fromJson(p0);
    }, apiCall);

    res.either(
      (left) =>
          throw RexApiException(
            message:
                res.left.responseMessage ?? StringConstants.exceptionMessage,
          ),
      (right) => tokenProvider.parseResponse(
        responseCode: res.isRight ? res.right.responseCode : '',
        errorAction:
            () => throw RexApiException(message: res.right.responseMessage),
      ),
    );
    return res.right;
  }

  Future<PosTransactionsResponse> posTransactions({
    required HeaderWithAuthNoCrypt header,
    required PosTransactionsRequest request,
  }) async {
    final apiCall = await tokenProvider.call(
      path: ApiPath.posTransactions(header.deviceID),
      method: RequestMethod.post,
      body: request.toJson(),
      options: Options(headers: ApiHeaders.withAuthNoCrypt(header)),
    );

    apiCall.either(
      (left) => debugPrintDev('RAW ERROR - POS TRANSACT: ${left.message}'),
      (right) => debugPrintDev('RAW RESPONSE - POS TRANSACT: ${right?.data}'),
    );

    final res = processData((p0) {
      return PosTransactionsResponse.fromJson(p0);
    }, apiCall);

    res.either(
      (left) =>
          throw RexApiException(
            message:
                res.left.responseMessage ?? StringConstants.exceptionMessage,
          ),
      (right) => tokenProvider.parseResponse(
        responseCode: res.isRight ? res.right.responseCode : '',
        errorAction:
            () => throw RexApiException(message: res.right.responseMessage),
      ),
    );
    return res.right;
  }

  Future<CreateDisputeResponse> posCreateDispute({
    required HeaderWithAuthNoCrypt header,
    required CreateDisputeRequest request,
  }) async {
    final apiCall = await tokenProvider.call(
      path: ApiPath.posCreateDispute,
      method: RequestMethod.post,
      body: request.toJson(),
      options: Options(headers: ApiHeaders.withAuthNoCrypt(header)),
    );

    apiCall.either(
      (left) => debugPrintDev('RAW ERROR - CREATE DISPUTE: ${left.message}'),
      (right) => debugPrintDev('RAW RESPONSE - CREATE DISPUTE: ${right?.data}'),
    );

    final res = processData(
      (p0) => CreateDisputeResponse.fromJson(p0),
      apiCall,
    );

    res.either(
      (left) {
        throw RexApiException(
          message: res.left.responseMessage ?? StringConstants.exceptionMessage,
        );
      },
      (right) => tokenProvider.parseResponse(
        responseCode: res.isRight ? res.right.responseCode : '',
        errorAction:
            () => throw RexApiException(message: res.right.responseMessage),
      ),
    );
    return res.right;
  }

  Future<FetchDisputeResponse> posFetchDispute({
    required HeaderWithAuthNoCrypt header,
  }) async {
    final apiCall = await tokenProvider.call(
      path: ApiPath.posFetchDispute,
      method: RequestMethod.post,
      options: Options(headers: ApiHeaders.withAuthNoCrypt(header)),
    );

    apiCall.either(
      (left) => debugPrintDev('RAW ERROR - FETCH DISPUTE: ${left.message}'),
      (right) => debugPrintDev('RAW RESPONSE - FETCH DISPUTE: ${right?.data}'),
    );

    final res = processData((p0) => FetchDisputeResponse.fromJson(p0), apiCall);

    res.either(
      (left) =>
          throw RexApiException(
            message:
                res.left.responseMessage ?? StringConstants.exceptionMessage,
          ),
      (right) => tokenProvider.parseResponse(
        responseCode: res.isRight ? res.right.responseCode : '',
        errorAction:
            () => throw RexApiException(message: res.right.responseMessage),
      ),
    );
    return res.right;
  }

  Future<RetrieveRrnResponse> posRetrieveRRN({
    required HeaderWithAuthNoCrypt header,
    required RetrieveRrnRequest request,
  }) async {
    final apiCall = await tokenProvider.call(
      path: ApiPath.posRetrieveRRN,
      method: RequestMethod.post,
      body: request.toJson(),
      options: Options(headers: ApiHeaders.withAuthNoCrypt(header)),
    );

    apiCall.either(
      (left) => debugPrintDev('RAW ERROR - RETRIEVE RRN: $left'),
      (right) => debugPrintDev('RAW RESPONSE - RETRIEVE RRN: ${right?.data}'),
    );

    final res = processData((p0) => RetrieveRrnResponse.fromJson(p0), apiCall);

    res.either(
      (left) =>
          throw RexApiException(
            message:
                res.left.responseMessage ?? StringConstants.exceptionMessage,
          ),
      (right) => tokenProvider.parseResponse(
        responseCode: res.isRight ? res.right.responseCode : '',
        errorAction:
            () => throw RexApiException(message: res.right.responseMessage),
      ),
    );
    return res.right;
  }

  Future<PosTsqResponse> posTsqCheck({
    required HeaderWithAuthNoCrypt header,
    required String rrn,
  }) async {
    final apiCall = await tokenProvider.call(
      path: ApiPath.posTsq(rrn),
      method: RequestMethod.get,
      options: Options(headers: ApiHeaders.withAuthNoCrypt(header)),
    );

    apiCall.either(
      (left) => debugPrintDev('RAW ERROR - TSQ CHECK: ${left.message}'),
      (right) => debugPrintDev('RAW RESPONSE - TSQ CHECK: ${right?.data}'),
    );

    final res = processData((p0) {
      return PosTsqResponse.fromJson(p0);
    }, apiCall);

    res.either(
      (left) =>
          throw RexApiException(
            message:
                res.left.responseMessage ?? StringConstants.exceptionMessage,
          ),
      (right) => tokenProvider.parseResponse(
        responseCode: res.isRight ? res.right.responseCode : '',
        errorAction:
            () => throw RexApiException(message: res.right.responseMessage),
      ),
    );
    return res.right;
  }

  Future<MiniStatementResponse> fetchMiniStatement({
    required HeaderWithAuthNoCrypt header,
    required MiniStatementRequest request,
  }) async {
    final response = await tokenProvider.call(
      path: ApiPath.miniStatement,
      method: RequestMethod.post,
      body: request.toJson(),
      options: Options(headers: ApiHeaders.withAuthNoCrypt(header)),
    );

    final res = processData(
      (p0) => MiniStatementResponse.fromJson(p0),
      response,
    );

    res.either(
      (left) =>
          throw RexApiException(
            message:
                res.left.responseMessage ?? StringConstants.exceptionMessage,
          ),
      (right) => tokenProvider.parseResponse(
        responseCode: res.isRight ? res.right.responseCode : '',
        errorAction:
            () => throw RexApiException(message: res.right.responseMessage),
      ),
    );

    return res.right;
  }

  Future<FetchDisputeResponse> fetchDisputes({
    required HeaderWithAuthNoCrypt header,
  }) async {
    final apiCall = await tokenProvider.call(
      path: ApiPath.fetchDispute,
      method: RequestMethod.post,
      options: Options(headers: ApiHeaders.withAuthNoCrypt(header)),
    );

    final res = processData((p0) => FetchDisputeResponse.fromJson(p0), apiCall);

    res.either(
      (left) =>
          throw RexApiException(
            message:
                res.left.responseMessage ?? StringConstants.exceptionMessage,
          ),
      (right) => tokenProvider.parseResponse(
        responseCode: res.isRight ? res.right.responseCode : '',
        errorAction:
            () => throw RexApiException(message: res.right.responseMessage),
      ),
    );
    return res.right;
  }
}
