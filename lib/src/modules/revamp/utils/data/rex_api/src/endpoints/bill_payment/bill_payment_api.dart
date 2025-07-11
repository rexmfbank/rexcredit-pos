import 'package:dio/dio.dart';
import 'package:rex_app/src/modules/revamp/utils/data/rex_api/rex_api.dart';
import '../utility/request/encrypt_request_template.dart';
import '../../utils/encryption_utils.dart';

import '../../exceptions/string_constants.dart';
import '../../exceptions/data_transformer.dart';
import '../../exceptions/rex_api_exception.dart';
import '../../utils/api_path.dart';
import '../../utils/dio_network_provider.dart';
import '../shared_models/api_headers.dart';

mixin BillPaymentApi {
  static final _tokenProvider = AppNetworkProvider();

  Future<BillerCategoriesResponse> fetchBillerCategories({
    required String authToken,
    required BillerCategoriesQuery query,
  }) async {
    final response = await _tokenProvider.call(
      path: ApiPath.getBillerCategories,
      method: RequestMethod.get,
      queryParams: query.toMap(),
      options: Options(
        headers: ApiHeaders.transactionRequestHeaderToken(authToken),
      ),
    );

    final res = processData(
      (p0) => BillerCategoriesResponse.fromJson(p0),
      response,
    );
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

  Future<BillersResponse> fetchBillers({
    required String authToken,
    required BillerQuery query,
  }) async {
    final response = await _tokenProvider.call(
      path: ApiPath.getBillers,
      method: RequestMethod.get,
      queryParams: query.toMap(),
      options: Options(
        headers: ApiHeaders.transactionRequestHeaderToken(authToken),
      ),
    );

    final res = processData((p0) => BillersResponse.fromJson(p0), response);
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

  Future<BillersResponse> fetchAllBillers({
    required String authToken,
    required BillerQuery query,
  }) async {
    final response = await _tokenProvider.call(
      path: ApiPath.getAllBillers,
      method: RequestMethod.get,
      queryParams: query.toMap(),
      options: Options(
        headers: ApiHeaders.transactionRequestHeaderToken(authToken),
      ),
    );

    final res = processData((p0) => BillersResponse.fromJson(p0), response);

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

  Future<ValidateBillResponse> validateBill({
    required String authToken,
    required ValidateBillRequest request,
  }) async {
    final response = await _tokenProvider.call(
      path: ApiPath.validateBill,
      method: RequestMethod.post,
      body: request.toJson(),
      options: Options(
        headers: ApiHeaders.transactionRequestHeaderToken(authToken),
      ),
    );

    final res =
        processData((p0) => ValidateBillResponse.fromJson(p0), response);
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

  Future<PostBillPaymentResponse> postBillPayment({
    required String authToken,
    required String appVersion,
    required String transactionPin,
    required PostBillPaymentRequest request,
  }) async {
    final response = await _tokenProvider.call(
      path: ApiPath.postBillPaymentV2,
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
          transactionPin: transactionPin,
        ),
      ),
    );

    final res = processData(
      (p0) {
        final jsonResponse = EncryptionUtils.decryptFromApi(p0);
        return PostBillPaymentResponse.fromJson(jsonResponse);
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

  Future<FetchBeneficiaryResponse> fetchTransactionBeneficiaries({
    required String authToken,
    required String accountNo,
    required String transCode,
  }) async {
    final response = await _tokenProvider.call(
      path: ApiPath.getTransactionBeneficiary,
      method: RequestMethod.get,
      queryParams: {'accountNo': accountNo, 'transCode': transCode},
      options: Options(
        headers: ApiHeaders.transactionRequestHeaderToken(authToken),
      ),
    );

    final res =
        processData((p0) => FetchBeneficiaryResponse.fromJson(p0), response);
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

  Future<FetchBeneficiaryResponse> deleteBeneficiariarie({
    required String authToken,
    required String accountNo,
    required String transCode,
    required String beneficiaryId,
  }) async {
    final response = await _tokenProvider.call(
      path: "${ApiPath.deleteBeneficiary}?id=$beneficiaryId",
      method: RequestMethod.get,
      queryParams: {'accountNo': accountNo, 'transCode': transCode},
      options: Options(
        headers: ApiHeaders.transactionRequestHeaderToken(authToken),
      ),
    );

    final res =
        processData((p0) => FetchBeneficiaryResponse.fromJson(p0), response);
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
}
