import 'package:dio/dio.dart';
import 'package:rex_app/src/data/rex_api/src/endpoints/pos/model/pos_auth_response.dart';
import 'package:rex_app/src/data/rex_api/src/endpoints/shared_models/api_headers.dart';
import 'package:rex_app/src/data/rex_api/src/exceptions/data_transformer.dart';
import 'package:rex_app/src/data/rex_api/src/exceptions/rex_api_exception.dart';
import 'package:rex_app/src/data/rex_api/src/exceptions/string_constants.dart';
import 'package:rex_app/src/data/rex_api/src/utils/api_path.dart';
import 'package:rex_app/src/data/rex_api/src/utils/dio_network_provider.dart';
import 'model/pos_card_purchase_response.dart';
import 'model/intent_transaction_result.dart';

mixin PosApi {
  final tokenProvider = AppNetworkProvider();

  Future<PosCardPurchaseResponse> posCardPurchase({
    required IntentTransactionResult request,
    required String authToken,
  }) async {
    final apiCall = await tokenProvider.call(
      path: ApiPath.cardPurchase,
      method: RequestMethod.post,
      options: Options(headers: ApiHeaders.headerNoTokenI),
      body: request.toJson(),
    );

    final res = processData(
      (p0) => PosCardPurchaseResponse.fromJson(p0),
      apiCall,
    );

    res.either(
      (left) => throw RexApiException(
        message: res.left.responseMessage ?? StringConstants.exceptionMessage,
      ),
      (right) => tokenProvider.parseResponse(
        responseCode: res.isRight ? res.right.responseCode : '',
        errorAction: () =>
            throw RexApiException(message: res.right.responseMessage),
      ),
    );
    return res.right;
  }

  Future<PosAuthResponse> posAuthentication({required String serialNo}) async {
    final apiCall = await tokenProvider.call(
        path: ApiPath.posAuth(serialNo),
        method: RequestMethod.get,
        options: Options(headers: ApiHeaders.headerNoTokenI));

    final res = processData(
      (p0) {
        return PosAuthResponse.fromJson(p0);
      },
      apiCall,
    );

    res.either(
      (left) => throw RexApiException(
        message: res.left.responseMessage ?? StringConstants.exceptionMessage,
      ),
      (right) => tokenProvider.parseResponse(
        responseCode: res.isRight ? res.right.responseCode : '',
        errorAction: () =>
            throw RexApiException(message: res.right.responseMessage),
      ),
    );
    return res.right;
  }
}
