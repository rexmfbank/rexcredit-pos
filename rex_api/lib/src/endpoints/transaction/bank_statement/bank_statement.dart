import 'package:dio/dio.dart';
import 'package:rex_api/src/endpoints/shared_models/api_headers.dart';
import 'package:rex_api/src/endpoints/transaction/bank_statement/models/bank_statement_request.dart';
import 'package:rex_api/src/endpoints/transaction/bank_statement/models/bank_statement_response.dart';
import 'package:rex_api/src/exceptions/data_transformer.dart';
import 'package:rex_api/src/exceptions/rex_api_exception.dart';
import 'package:rex_api/src/exceptions/string_constants.dart';
import 'package:rex_api/src/utils/api_path.dart';
import 'package:rex_api/src/utils/dio_network_provider.dart';

mixin BankStatement {
  final tokenProvider = AppNetworkProvider();

  Future<BankStatementResponse> requestBankStatement({
    required String authToken,
    required BankStatementRequest request,
  }) async {
    final apiCall = await tokenProvider.call(
      path: ApiPath.bankStatement,
      method: RequestMethod.post,
      body: request.toJson(),
      options: Options(headers: ApiHeaders.requestHeaderWithToken(authToken)),
    );

    final res = processData(
      (p0) => BankStatementResponse.fromJson(p0),
      apiCall,
    );

    res.either(
      (left) => throw RexApiException(
        message: res.left.responseMessage ?? StringConstants.exceptionMessage2,
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
