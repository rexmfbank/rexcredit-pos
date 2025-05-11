import 'package:dio/dio.dart';
import 'package:rex_app/src/data/rex_api/rex_api.dart';
import '../../shared_models/api_headers.dart';
import '../../../exceptions/data_transformer.dart';
import '../../../exceptions/rex_api_exception.dart';
import '../../../exceptions/string_constants.dart';
import '../../../utils/api_path.dart';
import '../../../utils/dio_network_provider.dart';

mixin LoanProductApi {
  static final _tokenProvider = AppNetworkProvider();

  Future<GetLoanProductsResponse> getLoanProducts({
    required String authToken,
  }) async {
    final response = await _tokenProvider.call(
      path: ApiPath.getLoanProducts,
      method: RequestMethod.get,
      options: Options(
        headers: ApiHeaders.requestHeaderWithToken(authToken),
      ),
    );

    final res =
        processData((p0) => GetLoanProductsResponse.fromJson(p0), response);
    res.either(
      (left) => throw RexApiException(
          message:
              res.left.responseMessage ?? StringConstants.exceptionMessage),
      (right) => _tokenProvider.parseResponse(
        responseCode: res.isRight ? res.right.responseCode : '',
        errorAction: () =>
            throw RexApiException(message: res.right.responseMessage),
      ),
    );

    return res.right;
  }

  Future<GetSingleLoanProductResponse> getSingleLoanProduct({
    required String authToken,
    required String productCode,
  }) async {
    final response = await _tokenProvider.call(
      path: ApiPath.getSingleLoanProduct + productCode,
      method: RequestMethod.get,
      options: Options(
        headers: ApiHeaders.requestHeaderWithToken(authToken),
      ),
    );

    final res = processData(
        (p0) => GetSingleLoanProductResponse.fromJson(p0), response);
    res.either(
      (left) => throw RexApiException(
          message:
              res.left.responseMessage ?? StringConstants.exceptionMessage),
      (right) => _tokenProvider.parseResponse(
        responseCode: res.isRight ? res.right.responseCode : '',
        errorAction: () =>
            throw RexApiException(message: res.right.responseMessage),
      ),
    );

    return res.right;
  }

  Future<ComputeLoanResponse> computeLoan(
      {required String authToken, required ComputeLoanRequest request}) async {
    final response = await _tokenProvider.call(
      path: ApiPath.computeLoan,
      method: RequestMethod.get,
      queryParams: {
        'loanAmount': request.loanAmount,
        'loanProductCode': request.loanProductCode,
        'tenor': request.tenor,
        'startDate': ""
      },
      body: request.toJson(),
      options: Options(
        headers: ApiHeaders.requestHeaderWithToken(authToken),
      ),
    );

    final res = processData((p0) => ComputeLoanResponse.fromJson(p0), response);
    res.either(
      (left) => throw RexApiException(
          message:
              res.left.responseMessage ?? StringConstants.exceptionMessage),
      (right) => _tokenProvider.parseResponse(
        responseCode: res.isRight ? res.right.responseCode : '',
        errorAction: () =>
            throw RexApiException(message: res.right.responseMessage),
      ),
    );

    return res.right;
  }
}
