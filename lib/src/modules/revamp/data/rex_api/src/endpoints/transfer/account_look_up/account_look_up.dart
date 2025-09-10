import 'package:dio/dio.dart';
import 'package:rex_app/src/modules/revamp/data/rex_api/rex_api.dart';
import '../../shared_models/api_headers.dart';
import '../../../exceptions/rex_api_exception.dart';
import '../../../exceptions/string_constants.dart';
import '../../../utils/api_path.dart';
import '../../../utils/dio_network_provider.dart';
import '../../../exceptions/data_transformer.dart';

mixin AccountLookUp {
  static final _tokenProvider = AppNetworkProvider();

  Future<AccountLookUpResponse> performInternalAccountLookUp({
    required String token,
    required AccountLookUpRequest request,
  }) async {
    final response = await _tokenProvider.call(
      path: ApiPath.internalAccountLookUp,
      method: RequestMethod.post,
      body: request.toJson(),
      options: Options(
        headers: ApiHeaders.transactionRequestHeaderToken(token),
      ),
    );

    final res =
        processData((p0) => AccountLookUpResponse.fromJson(p0), response);
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

  Future<AccountLookUpResponse> performInterAccountLookUp({
    required String token,
    required AccountLookUpRequest request,
  }) async {
    final response = await _tokenProvider.call(
      path: ApiPath.interAccountLookUp,
      method: RequestMethod.post,
      body: request.toJson(),
      options: Options(
        headers: ApiHeaders.transactionRequestHeaderToken(token),
      ),
    );

    final res =
        processData((p0) => AccountLookUpResponse.fromJson(p0), response);
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
