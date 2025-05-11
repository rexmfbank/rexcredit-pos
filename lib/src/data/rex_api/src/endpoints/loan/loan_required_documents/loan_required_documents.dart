import 'package:dio/dio.dart';
import 'package:rex_app/src/data/rex_api/rex_api.dart';
import '../../shared_models/api_headers.dart';
import '../../../exceptions/data_transformer.dart';
import '../../../exceptions/rex_api_exception.dart';
import '../../../exceptions/string_constants.dart';
import '../../../utils/api_path.dart';
import '../../../utils/dio_network_provider.dart';

mixin LoanProductRequiredDocuments {
  static final _tokenProvider = AppNetworkProvider();

  Future<dynamic> getLoanProductRequiredDocument({
    required String authToken,
    required int loanProductCode,
  }) async {
    final response = await _tokenProvider.call(
      path: ApiPath.getLoanProductRequiredDocuments(loanProductCode),
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
}
