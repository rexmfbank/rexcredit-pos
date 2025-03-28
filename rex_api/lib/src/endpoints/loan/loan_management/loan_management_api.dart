import 'package:dio/dio.dart';
import 'package:rex_api/src/endpoints/loan/loan_management/model/fetch_loan_data.dart';
import 'package:rex_api/src/endpoints/loan/loan_management/model/loan_repayment_request.dart';
import 'package:rex_api/src/endpoints/loan/loan_management/model/loan_repayment_response.dart';
import 'package:rex_api/src/endpoints/shared_models/api_headers.dart';
import 'package:rex_api/src/exceptions/data_transformer.dart';
import 'package:rex_api/src/exceptions/rex_api_exception.dart';
import 'package:rex_api/src/exceptions/string_constants.dart';
import 'package:rex_api/src/utils/api_path.dart';
import 'package:rex_api/src/utils/dio_network_provider.dart';

mixin LoanManagementApi {
  static final _tokenProvider = AppNetworkProvider();

  Future<LoanManagementResponse> getLoanDetail({
    required String token,
  }) async {
    final response = await _tokenProvider.call(
      path: ApiPath.getLoanDetails,
      method: RequestMethod.get,
      options: Options(
        headers: ApiHeaders.requestHeaderWithToken(token),
      ),
    );

    final res =
        processData((p0) => LoanManagementResponse.fromJson(p0), response);
    print(res);
    res.either(
      (left) => throw RexApiException(
          message: res.left.responseMessage ?? StringConstants.exceptionMessage),
      (right) => _tokenProvider.parseResponse(
        responseCode: res.isRight ? res.right.responseCode ?? 'null' : '',
        errorAction: () =>
            throw RexApiException(message: res.right.responseMessage),
      ),
    );

    return res.right;
  }

  Future<LoanRepaymentResponse> repayLoan({
    required String authToken,
    required LoanRepaymentRequest request,
  }) async {
    final apiCall = await _tokenProvider.call(
      path: ApiPath.repayLoan,
      method: RequestMethod.post,
      options: Options(headers: ApiHeaders.requestHeaderWithToken(authToken)),
      body: request.toJson(),
    );
    final res = processData(
      (p0) => LoanRepaymentResponse.fromJson(p0),
      apiCall,
    );

    res.either(
      (left) => throw RexApiException(
        message: res.left.responseMessage ?? StringConstants.exceptionMessage,
      ),
      (right) => _tokenProvider.parseResponse(
        responseCode: res.isRight ? res.right.responseCode : '',
        errorAction: () => throw RexApiException(
          message: res.right.responseMessage,
        ),
      ),
    );
    return res.right;
  }
}
