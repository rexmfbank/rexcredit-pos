import 'package:dio/dio.dart';
import 'package:rex_app/src/modules/api/models/transaction_query_payload.dart';
import 'package:rex_app/src/modules/api/rex_api.dart';
import 'package:rex_app/src/modules/api/dio/api_headers.dart';
import 'package:rex_app/src/modules/api/dio/api_response.dart';
import 'package:rex_app/src/modules/api/dio/data_transformer.dart';
import 'package:rex_app/src/modules/api/exceptions/rex_api_exception.dart';
import 'package:rex_app/src/modules/api/exceptions/string_constants.dart';
import 'package:rex_app/src/modules/api/dio/api_path.dart';
import 'package:rex_app/src/modules/api/dio/dio_network_provider.dart';
import 'package:rex_app/src/modules/api/dio/error_code.dart';
import 'package:rex_app/src/modules/utils/general/app_functions.dart';

mixin PosEndpoints {
  final tokenProvider = AppNetworkProvider();

  Future<PosAuthResponse> posAuthentication({
    required HeaderNoAuthNoCrypt header,
  }) async {
    debugPrintDev("header for posAuthentication: ${header.toJson()}");
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
    debugPrintDev("header for quick purchase: ${header.toJson()}");
    debugPrintDev("request for quick purchase: ${request.toJson()}");
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
    debugPrintDev("header for posNfcPurchase: ${header.toJson()}");
    debugPrintDev("request for posNfcPurchase: ${request.toJson()}");
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
    debugPrintDev("header for posTransactions: ${header.toJson()}");
    debugPrintDev("request for posTransactions: ${request.toJson()}");
    final apiCall = await tokenProvider.call(
      path: ApiPath.posTransactions(header.deviceID),
      method: RequestMethod.post,
      body: request.toJson(),
      options: Options(headers: ApiHeaders.withAuthNoCrypt(header)),
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

  Future<DisputeResponseData?> posCreateDispute({
    required HeaderWithAuthNoCrypt header,
    required CreateDisputeRequest request,
  }) async {
    try {
      final response = await ApiLib.getDioInstance().post(
        ApiPath.posCreateDispute,
        data: request.toJson(),
        options: Options(headers: ApiHeaders.withAuthNoCrypt(header)),
      );

      debugPrintDev("response for posCreateDispute: ${response.data}");

      final disputeResponse = CreateDisputeResponse.fromJson(response.data);
      if (disputeResponse.responseCode != ErrorCode.SUCCESS) {
        throw ApiException(
          message: disputeResponse.responseMessage,
          status: disputeResponse.responseCode,
        );
      }
      return disputeResponse.data;
    } on DioException catch (e) {
      final errorMessage = mapDioExceptionToMessage(e);
      debugPrintDev("errorMessage for posCreateDispute: $errorMessage");
      throw ApiException(
        message: errorMessage,
        status: "${e.response?.statusCode}",
      );
    } catch (err) {
      if (err is ApiException) rethrow;
      debugPrintDev("error for posCreateDispute: $err");
      throw ApiException(
        message: 'An unexpected error occurred: $err',
        status: '0',
      );
    }
  }

  Future<List<DisputeReasonItem>> posDisputeReasons({
    required HeaderWithAuthNoCrypt header,
  }) async {
    try {
      final response = await ApiLib.getDioInstance().get(
        ApiPath.posDisputeReasons,
        options: Options(headers: ApiHeaders.withAuthNoCrypt(header)),
      );

      final body = response.data as Map<String, dynamic>;
      final responseCode = body['responseCode']?.toString() ?? '';
      final responseMessage = body['responseMessage']?.toString() ?? '';
      if (responseCode != ErrorCode.SUCCESS) {
        throw ApiException(message: responseMessage, status: responseCode);
      }

      final data = body['data'];
      if (data is! List) return [];
      return data
          .map((e) => DisputeReasonItem.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      final errorMessage = mapDioExceptionToMessage(e);
      throw ApiException(
        message: errorMessage,
        status: "${e.response?.statusCode}",
      );
    } catch (err) {
      if (err is ApiException) rethrow;
      throw ApiException(
        message: 'An unexpected error occurred: $err',
        status: '0',
      );
    }
  }

  Future<List<FetchDisputeData>> posFetchDispute({
    required HeaderWithAuthNoCrypt header,
  }) => _fetchDisputeList(path: ApiPath.posFetchDispute, header: header);

  /// This endpoint still answers with the responseCode envelope rather than the
  /// status/message one, so it is parsed directly instead of via [ApiResponse].
  Future<List<FetchDisputeData>> _fetchDisputeList({
    required String path,
    required HeaderWithAuthNoCrypt header,
  }) async {
    try {
      final response = await ApiLib.getDioInstance().get(
        path,
        options: Options(headers: ApiHeaders.withAuthNoCrypt(header)),
      );

      final disputeResponse = FetchDisputeResponse.fromJson(response.data);
      if (disputeResponse.responseCode != ErrorCode.SUCCESS) {
        throw ApiException(
          message: disputeResponse.responseMessage,
          status: disputeResponse.responseCode,
        );
      }
      return disputeResponse.data?.items ?? [];
    } on DioException catch (e) {
      final errorMessage = mapDioExceptionToMessage(e);
      throw ApiException(
        message: errorMessage,
        status: "${e.response?.statusCode}",
      );
    } catch (err) {
      if (err is ApiException) rethrow;
      throw ApiException(
        message: 'An unexpected error occurred: $err',
        status: '0',
      );
    }
  }

  Future<RetrieveRrnResponse> posRetrieveRRN({
    required HeaderWithAuthNoCrypt header,
    required RetrieveRrnRequest request,
  }) async {
    debugPrintDev("header for rrn: ${header.toJson()}");
    debugPrintDev("request for rrn: ${request.toJson()}");
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
    debugPrintDev("header for posTsqCheck: ${header.toJson()}");
    debugPrintDev("rrn for posTsqCheck: $rrn");
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
    debugPrintDev("header for fetchMiniStatement: ${header.toJson()}");
    debugPrintDev("request for fetchMiniStatement: ${request.toJson()}");
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

  Future<List<FetchDisputeData>> fetchDisputes({
    required HeaderWithAuthNoCrypt header,
  }) => _fetchDisputeList(path: ApiPath.fetchDispute, header: header);

  Future<TransactionQueryResponse> posTransactionQuery({
    required HeaderWithAuthNoCrypt header,
    required String transactionRef,
  }) async {
    final apiCall = await tokenProvider.call(
      path: ApiPath.posRequery(transactionRef),
      method: RequestMethod.get,
      options: Options(headers: ApiHeaders.withAuthNoCrypt(header)),
    );

    final res = processData((p0) {
      return TransactionQueryResponse.fromJson(p0);
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
}
