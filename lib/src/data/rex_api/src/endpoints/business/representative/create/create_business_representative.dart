import 'package:dio/dio.dart';
import 'package:rex_app/src/data/rex_api/rex_api.dart';
import '../../../shared_models/api_headers.dart';
import '../../../../exceptions/data_transformer.dart';
import '../../../../exceptions/rex_api_exception.dart';
import '../../../../exceptions/string_constants.dart';
import '../../../../utils/api_path.dart';
import '../../../../utils/dio_network_provider.dart';

mixin CreateBusinessRepresentative {
  static final _tokenProvider = AppNetworkProvider();

  Future<CreateRepresentativeResponse> createBusinessRepresentative({
    required String token,
    required CreateRepresentativeRequest request,
  }) async {
    final response = await _tokenProvider.call(
      path: ApiPath.createBusinessRepresentative,
      method: RequestMethod.post,
      body: request.toJson(),
      options: Options(
        headers: ApiHeaders.requestHeaderWithToken(token),
      ),
    );

    final res = processData(
        (p0) => CreateRepresentativeResponse.fromJson(p0), response);
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
