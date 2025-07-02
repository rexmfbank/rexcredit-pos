import 'package:dio/dio.dart';
import '../../shared_models/api_headers.dart';
import 'models/bank_statement_request.dart';
import 'models/bank_statement_response.dart';
import '../../../exceptions/data_transformer.dart';
import '../../../exceptions/rex_api_exception.dart';
import '../../../exceptions/string_constants.dart';
import '../../../utils/api_path.dart';
import '../../../utils/dio_network_provider.dart';

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
