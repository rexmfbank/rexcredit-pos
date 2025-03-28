import 'package:dio/dio.dart';
import 'package:rex_api/src/endpoints/card_payment/list/models/card_list_response.dart';
import 'package:rex_api/src/endpoints/shared_models/api_headers.dart';
import 'package:rex_api/src/exceptions/data_transformer.dart';
import 'package:rex_api/src/exceptions/rex_api_exception.dart';
import 'package:rex_api/src/exceptions/string_constants.dart';
import 'package:rex_api/src/utils/api_path.dart';
import 'package:rex_api/src/utils/dio_network_provider.dart';
import 'package:rex_api/src/utils/encryption_utils.dart';

mixin CardList {
  static final _tokenProvider = AppNetworkProvider();

  Future<CardListResponse> cardList({
    required String authToken,
    required String appVersion,
  }) async {
    final response = await _tokenProvider.call(
      path: ApiPath.cardListV2,
      method: RequestMethod.get,
      options: Options(
        headers: ApiHeaders.encryptedTransactionRequestHeaderToken(
          authToken,
          xAppVersion: appVersion,
        ),
      ),
    );

    final res = processData(
      (p0) {
        final jsonResponse = EncryptionUtils.decryptFromApi(p0);
        return CardListResponse.fromJson(jsonResponse);
      },
      response,
    );
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
