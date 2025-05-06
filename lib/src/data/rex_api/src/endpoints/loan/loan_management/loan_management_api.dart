import 'package:dio/dio.dart';
import 'model/fetch_loan_data.dart';
import 'model/loan_repayment_request.dart';
import 'model/loan_repayment_response.dart';
import '../../shared_models/api_headers.dart';
import '../../../exceptions/data_transformer.dart';
import '../../../exceptions/rex_api_exception.dart';
import '../../../exceptions/string_constants.dart';
import '../../../utils/api_path.dart';
import '../../../utils/dio_network_provider.dart';

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
