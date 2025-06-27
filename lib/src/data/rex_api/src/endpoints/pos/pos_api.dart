import 'package:dio/dio.dart';
import 'model/pos_card_purchase_response.dart';
import 'model/intent_transaction_result.dart';
import '../shared_models/api_headers.dart';
import '../../exceptions/data_transformer.dart';
import '../../exceptions/rex_api_exception.dart';
import '../../exceptions/string_constants.dart';
import '../../utils/api_path.dart';
import '../../utils/dio_network_provider.dart';

mixin PosApi {
  final tokenProvider = AppNetworkProvider();

  Future<PosCardPurchaseResponse> posCardPurchase({
    required IntentTransactionResult request,
    required String authToken,
  }) async {
    final apiCall = await tokenProvider.call(
      path: ApiPath.cardPurchase,
      method: RequestMethod.post,
      options: Options(headers: ApiHeaders.requestHeader),
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
}
