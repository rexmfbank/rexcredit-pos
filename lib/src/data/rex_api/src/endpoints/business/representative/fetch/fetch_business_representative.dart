import 'package:dio/dio.dart';
import 'package:rex_app/src/data/rex_api/rex_api.dart';
import '../../../shared_models/api_headers.dart';
import '../../../../exceptions/data_transformer.dart';
import '../../../../exceptions/rex_api_exception.dart';
import '../../../../exceptions/string_constants.dart';
import '../../../../utils/api_path.dart';
import '../../../../utils/dio_network_provider.dart';

mixin FetchBusinessRepresentative {
  static final _tokenProvider = AppNetworkProvider();

  Future<FetchRepresentativeResponse> fetchBusinessRepresentative(
      {required String token, required String email}) async {
    final response = await _tokenProvider.call(
      path: ApiPath.fetchBusinessRepresentative,
      method: RequestMethod.get,
      queryParams: {'email': email},
      options: Options(
        headers: ApiHeaders.requestHeaderWithToken(token),
      ),
    );

    final res =
        processData((p0) => FetchRepresentativeResponse.fromJson(p0), response);
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
