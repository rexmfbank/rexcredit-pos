import 'package:dio/dio.dart';
import 'package:rex_api/rex_api.dart';
import 'package:rex_api/src/endpoints/shared_models/api_headers.dart';
import 'package:rex_api/src/endpoints/utility/request/encrypt_request_template.dart';
import 'package:rex_api/src/exceptions/data_transformer.dart';
import 'package:rex_api/src/exceptions/rex_api_exception.dart';
import 'package:rex_api/src/exceptions/string_constants.dart';
import 'package:rex_api/src/utils/api_path.dart';
import 'package:rex_api/src/utils/dio_network_provider.dart';
import 'package:rex_api/src/utils/encryption_utils.dart';

mixin TransferApi {
  static final _tokenProvider = AppNetworkProvider();

  Future<ListOfBanks> getBankList({
    required String authToken,
  }) async {
    final response = await _tokenProvider.call(
      path: ApiPath.getBanks,
      method: RequestMethod.get,
      options: Options(
        headers: ApiHeaders.transactionRequestHeaderToken(authToken),
      ),
    );

    final res = processData((p0) => ListOfBanks.fromJson(p0), response);
    res.either(
      (left) => throw RexApiException(
        message: res.left.responseMessage ?? StringConstants.exceptionMessage,
      ),
      (right) => _tokenProvider.parseResponse(
        responseCode: res.isRight ? res.right.responseCode : '',
        errorAction: () =>
            throw RexApiException(message: res.right.responseMessage),
      ),
    );

    return res.right;
  }

  Future<TransferResponse> interBankTransfer({
    required String authToken,
    required String appVersion,
    required InterBankTransferRequest request,
  }) async {
    final response = await _tokenProvider.call(
      path: ApiPath.completeTransferV2,
      method: RequestMethod.post,
      body: EncryptRequestTemplate(
        data: EncryptionUtils.encryptToApi(
          request.toJson(),
        ),
      ).toJson(),
      options: Options(
        headers: ApiHeaders.encryptedTransactionRequestHeaderToken(
          authToken,
          xAppVersion: appVersion,
          transactionPin: request.pin,
        ),
      ),
    );

    final res = processData(
      (p0) {
        final jsonResponse = EncryptionUtils.decryptFromApi(p0);
        print(jsonResponse);
        return TransferResponse.fromJson(jsonResponse);
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

  Future<BankUptimeResponse> bankUptime({
    required String authToken,
  }) async {
    final apiCall = await _tokenProvider.call(
      path: ApiPath.bankUptime,
      method: RequestMethod.get,
      options: Options(
        headers: ApiHeaders.requestHeaderWithToken(authToken),
      ),
    );

    final res = processData((p0) => BankUptimeResponse.fromJson(p0), apiCall);

    res.either(
      (left) {
        throw RexApiException(
          message: res.left.message ?? StringConstants.exceptionMessage2,
        );
      },
      (right) => _tokenProvider.parseResponse(
        responseCode: res.isRight ? res.right.responseCode : '',
        errorAction: () =>
            throw RexApiException(message: res.right.responseMessage),
      ),
    );
    return res.right;
  }
}
