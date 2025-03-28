import 'package:dio/dio.dart';
import 'package:rex_api/src/endpoints/card_services/request/activate_card_request.dart';
import 'package:rex_api/src/endpoints/card_services/request/card_action_request.dart';
import 'package:rex_api/src/endpoints/card_services/request/card_replacement_request.dart';
import 'package:rex_api/src/endpoints/card_services/request/card_request.dart';
import 'package:rex_api/src/endpoints/card_services/request/change_pin_request.dart';
import 'package:rex_api/src/endpoints/card_services/request/set_withdrawal_limit_request.dart';
import 'package:rex_api/src/endpoints/card_services/request/verify_card_otp_request.dart';
import 'package:rex_api/src/endpoints/card_services/responses/activate_card_response.dart';
import 'package:rex_api/src/endpoints/card_services/responses/card_action_response.dart';
import 'package:rex_api/src/endpoints/card_services/responses/card_product_response.dart';
import 'package:rex_api/src/endpoints/card_services/responses/card_replacement_response.dart';
import 'package:rex_api/src/endpoints/card_services/responses/card_request_response.dart';
import 'package:rex_api/src/endpoints/card_services/responses/get_card_details_response.dart';
import 'package:rex_api/src/endpoints/card_services/responses/get_card_list_response.dart';
import 'package:rex_api/src/endpoints/card_services/responses/set_card_withdrawal_response.dart';
import 'package:rex_api/src/endpoints/shared_models/api_headers.dart';
import 'package:rex_api/src/endpoints/utility/request/encrypt_request_template.dart';
import 'package:rex_api/src/endpoints/utility/response/rex_response_template.dart';
import 'package:rex_api/src/exceptions/data_transformer.dart';
import 'package:rex_api/src/exceptions/rex_api_exception.dart';
import 'package:rex_api/src/exceptions/string_constants.dart';
import 'package:rex_api/src/utils/api_path.dart';
import 'package:rex_api/src/utils/dio_network_provider.dart';
import 'package:rex_api/src/utils/encryption_utils.dart';

mixin CardServicesApi {
  static final _tokenProvider = AppNetworkProvider();

  Future<GetCardResponse> getCardList({
    required String authToken,
    required String appVersion,
  }) async {
    final response = await _tokenProvider.call(
      path: ApiPath.getCardListV2,
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
        return GetCardResponse.fromJson(jsonResponse);
      },
      response,
    );

    res.either(
      (left) => throw RexApiException(
        message: res.left.responseMessage ?? StringConstants.exceptionMessage,
      ),
      (right) => _tokenProvider.parseResponse(
        responseCode: res.isRight ? res.right.responseCode! : '',
        errorAction: () =>
            throw RexApiException(message: res.right.responseMessage),
      ),
    );

    return res.right;
  }

  Future<GetCardDetailsResponse> getCardDetails({
    required String authToken,
    required String appVersion,
    required String cardID,
  }) async {
    final response = await _tokenProvider.call(
      path: ApiPath.getCardDetailsV2(cardID),
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
        return GetCardDetailsResponse.fromJson(jsonResponse);
      },
      response,
    );

    res.either(
      (left) => throw RexApiException(
          message:
              res.left.responseMessage ?? StringConstants.exceptionMessage),
      (right) => _tokenProvider.parseResponse(
        responseCode: res.isRight ? res.right.responseCode! : '',
        errorAction: () =>
            throw RexApiException(message: res.right.responseMessage),
      ),
    );

    return res.right;
  }

  Future<CardRequestResponse> postCardRequest({
    required String authToken,
    required String appVersion,
    required CardRequest request,
  }) async {
    final response = await _tokenProvider.call(
      path: ApiPath.requestCardV2,
      method: RequestMethod.post,
      body: EncryptRequestTemplate(
        data: EncryptionUtils.encryptToApi(request.toJson()),
      ).toJson(),
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
        return CardRequestResponse.fromJson(jsonResponse);
      },
      response,
    );

    res.either(
      (left) => throw RexApiException(
          message:
              res.left.responseMessage ?? StringConstants.exceptionMessage),
      (right) => _tokenProvider.parseResponse(
        responseCode: res.isRight ? res.right.responseCode! : '',
        errorAction: () =>
            throw RexApiException(message: res.right.responseMessage),
      ),
    );

    return res.right;
  }

  Future<CardProductsResponse> getCardProducts({
    required String authToken,
    required String appVersion,
  }) async {
    final response = await _tokenProvider.call(
      path: ApiPath.getCardProductsV2,
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
        return CardProductsResponse.fromJson(jsonResponse);
      },
      response,
    );

    res.either(
      (left) => throw RexApiException(
          message:
              res.left.responseMessage ?? StringConstants.exceptionMessage),
      (right) => _tokenProvider.parseResponse(
        responseCode: res.isRight ? res.right.responseCode! : '',
        errorAction: () =>
            throw RexApiException(message: res.right.responseMessage),
      ),
    );

    return res.right;
  }

  Future<CardActionResponse> blockCard({
    required String authToken,
    required String appVersion,
    required CardActionRequest request,
  }) async {
    final response = await _tokenProvider.call(
      path: ApiPath.blockCardV2,
      method: RequestMethod.post,
      body: EncryptRequestTemplate(
        data: EncryptionUtils.encryptToApi(request.toJson()),
      ).toJson(),
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
        return CardActionResponse.fromJson(jsonResponse);
      },
      response,
    );

    res.either(
      (left) => throw RexApiException(
          message:
              res.left.responseMessage ?? StringConstants.exceptionMessage),
      (right) => _tokenProvider.parseResponse(
        responseCode: res.isRight ? res.right.responseCode! : '',
        errorAction: () =>
            throw RexApiException(message: res.right.responseMessage),
      ),
    );

    return res.right;
  }

  Future<CardActionResponse> unblockCard(
      {required String authToken,
      required String appVersion,
      required CardActionRequest request}) async {
    final response = await _tokenProvider.call(
      path: ApiPath.unBlockCard,
      method: RequestMethod.post,
      body: EncryptRequestTemplate(
        data: EncryptionUtils.encryptToApi(request.toJson()),
      ).toJson(),
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
        return CardActionResponse.fromJson(jsonResponse);
      },
      response,
    );

    res.either(
      (left) => throw RexApiException(
          message:
              res.left.responseMessage ?? StringConstants.exceptionMessage),
      (right) => _tokenProvider.parseResponse(
        responseCode: res.isRight ? res.right.responseCode! : '',
        errorAction: () =>
            throw RexApiException(message: res.right.responseMessage),
      ),
    );

    return res.right;
  }

  Future<ActivateCardResponse> activateCard({
    required String authToken,
    required String appVersion,
    required String cardID,
    required ActivateCardRequest request,
  }) async {
    final response = await _tokenProvider.call(
      path: ApiPath.activateCardV2(cardID),
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
        ),
      ),
    );

    final res = processData(
      (p0) {
        final jsonResponse = EncryptionUtils.decryptFromApi(p0);
        return ActivateCardResponse.fromJson(jsonResponse);
      },
      response,
    );

    res.either(
      (left) => throw RexApiException(
          message:
              res.left.responseMessage ?? StringConstants.exceptionMessage),
      (right) => _tokenProvider.parseResponse(
        responseCode: res.isRight ? res.right.responseCode! : '',
        errorAction: () =>
            throw RexApiException(message: res.right.responseMessage),
      ),
    );

    return res.right;
  }

  ///Fix Reset Pin OTP
  Future<RexResponseTemplate> resetPinRequest(
      {required String authToken, required String cardId}) async {
    final response = await _tokenProvider.call(
      path: ApiPath.requestChangePinOTP(cardId),
      method: RequestMethod.post,
      options: Options(
        headers: ApiHeaders.transactionRequestHeaderToken(authToken),
      ),
    );

    final res = processData((p0) => RexResponseTemplate.fromJson(p0), response);
    res.either(
      (left) => throw RexApiException(
          message:
              res.left.responseMessage ?? StringConstants.exceptionMessage),
      (right) => _tokenProvider.parseResponse(
        responseCode: res.isRight ? res.right.responseCode! : '',
        errorAction: () =>
            throw RexApiException(message: res.right.responseMessage),
      ),
    );

    return res.right;
  }

  ///Fix Reset Pin OTP
  Future<RexResponseTemplate> verifyCardOTP(
      {required String authToken,
      required VerifyCardOtpRequest request}) async {
    final response = await _tokenProvider.call(
      path: ApiPath.verifyChangePinOTP,
      method: RequestMethod.post,
      body: request.toJson(),
      options: Options(
        headers: ApiHeaders.transactionRequestHeaderToken(authToken),
      ),
    );

    final res = processData((p0) => RexResponseTemplate.fromJson(p0), response);
    res.either(
      (left) => throw RexApiException(
          message:
              res.left.responseMessage ?? StringConstants.exceptionMessage),
      (right) => _tokenProvider.parseResponse(
        responseCode: res.isRight ? res.right.responseCode! : '',
        errorAction: () =>
            throw RexApiException(message: res.right.responseMessage),
      ),
    );

    return res.right;
  }

  ///Fix Change Pin Response
  Future<RexResponseTemplate> setCardPin(
      {required String authToken,
      required String appVersion,
      required ChangeCardPinRequest request}) async {
    final response = await _tokenProvider.call(
      path: ApiPath.resetPinV2,
      method: RequestMethod.post,
      body: EncryptRequestTemplate(
        data: EncryptionUtils.encryptToApi(request.toJson()),
      ).toJson(),
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
        return RexResponseTemplate.fromJson(jsonResponse);
      },
      response,
    );

    res.either(
      (left) => throw RexApiException(
          message:
              res.left.responseMessage ?? StringConstants.exceptionMessage),
      (right) => _tokenProvider.parseResponse(
        responseCode: res.isRight ? res.right.responseCode! : '',
        errorAction: () =>
            throw RexApiException(message: res.right.responseMessage),
      ),
    );

    return res.right;
  }

  Future<SetCardWithdrawalResponse> setCardWithdrawalLimit(
      {required String authToken,
      required String appVersion,
      required SetCardWithdrawalLimitRequest request}) async {
    final response = await _tokenProvider.call(
      path: ApiPath.setCardWithdrawalLimitV2,
      method: RequestMethod.put,
      body: EncryptRequestTemplate(
        data: EncryptionUtils.encryptToApi(
          request.toJson(),
        ),
      ).toJson(),
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
        return SetCardWithdrawalResponse.fromJson(jsonResponse);
      },
      response,
    );

    res.either(
      (left) => throw RexApiException(
          message:
              res.left.responseMessage ?? StringConstants.exceptionMessage),
      (right) => _tokenProvider.parseResponse(
        responseCode: res.isRight ? res.right.responseCode! : '',
        errorAction: () =>
            throw RexApiException(message: res.right.responseMessage),
      ),
    );

    return res.right;
  }

  Future<CardReplacementResponse> postCardReplacement(
      {required String authToken,
      required CardReplacementRequest request}) async {
    final response = await _tokenProvider.call(
      path: ApiPath.replaceCard,
      method: RequestMethod.post,
      body: request.toJson(),
      options: Options(
        headers: ApiHeaders.requestHeaderWithToken(authToken),
      ),
    );

    final res =
        processData((p0) => CardReplacementResponse.fromJson(p0), response);
    res.either(
      (left) => throw RexApiException(
          message:
              res.left.responseMessage ?? StringConstants.exceptionMessage),
      (right) => _tokenProvider.parseResponse(
        responseCode: res.isRight ? res.right.responseCode! : '',
        errorAction: () =>
            throw RexApiException(message: res.right.responseMessage),
      ),
    );

    return res.right;
  }
}
