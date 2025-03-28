import 'package:dio/dio.dart';
import 'package:rex_api/rex_api.dart';
import 'package:rex_api/src/endpoints/loan/loan_application/models/loan_application_initiated_request.dart';
import 'package:rex_api/src/endpoints/shared_models/api_headers.dart';
import 'package:rex_api/src/endpoints/utility/request/encrypt_request_template.dart';
import 'package:rex_api/src/exceptions/data_transformer.dart';
import 'package:rex_api/src/exceptions/rex_api_exception.dart';
import 'package:rex_api/src/exceptions/string_constants.dart';
import 'package:rex_api/src/utils/api_path.dart';
import 'package:rex_api/src/utils/dio_network_provider.dart';
import 'package:rex_api/src/utils/encryption_utils.dart';

mixin LoanApplicationApi {
  static final _tokenProvider = AppNetworkProvider();

  Future<LoanApplicationGeneralResponse> makeLoanApplicationGeneral({
    required String authToken,
    required String appVersion,
    required LoanApplicationGeneralRequest request,
  }) async {
    final cryptRequest = EncryptionUtils.encryptToApi(request.toJson());

    final response = await _tokenProvider.call(
      path: ApiPath.makeLoanApplicationV2,
      method: RequestMethod.post,
      body: EncryptRequestTemplate(data: cryptRequest).toJson(),
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
        return LoanApplicationGeneralResponse.fromJson(jsonResponse);
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

  Future<LoanApplicationGeneralResponse> makeLoanApplicationGuarantor({
    required String authToken,
    required String appVersion,
    required LoanApplicationGuarantorRequest request,
  }) async {
    final cryptRequest = EncryptionUtils.encryptToApi(request.toJson());

    final response = await _tokenProvider.call(
      path: ApiPath.makeLoanApplicationV2,
      method: RequestMethod.post,
      body: EncryptRequestTemplate(data: cryptRequest).toJson(),
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
        return LoanApplicationGeneralResponse.fromJson(jsonResponse);
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

  Future<LoanApplicationGeneralResponse> makeLoanApplicationStageOne({
    required String authToken,
    required String appVersion,
    required LoanApplicationStageOneRequest request,
  }) async {
    final cryptRequest = EncryptionUtils.encryptToApi(request.toJson());

    final response = await _tokenProvider.call(
      path: ApiPath.makeLoanApplicationV2,
      method: RequestMethod.post,
      body: EncryptRequestTemplate(data: cryptRequest).toJson(),
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
        return LoanApplicationGeneralResponse.fromJson(jsonResponse);
      },
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

  Future<LoanApplicationGeneralResponse> makeLoanApplicationEmployer({
    required String authToken,
    required String appVersion,
    required LoanApplicationEmployerRequest request,
  }) async {
    final cryptRequest = EncryptionUtils.encryptToApi(request.toJson());

    final response = await _tokenProvider.call(
      path: ApiPath.makeLoanApplicationV2,
      method: RequestMethod.post,
      body: EncryptRequestTemplate(data: cryptRequest).toJson(),
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
        return LoanApplicationGeneralResponse.fromJson(jsonResponse);
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

  Future<LoanApplicationsResponse> fetchUserLoanApplication({
    required String authToken,
  }) async {
    final response = await _tokenProvider.call(
      path: ApiPath.loanApplication,
      method: RequestMethod.get,
      options: Options(
        headers: ApiHeaders.requestHeaderWithToken(authToken),
      ),
    );

    final res = processData(
      (p0) => LoanApplicationsResponse.fromJson(p0),
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

  Future<LoanApplicationGeneralResponse> fetchSingleLoanApplication({
    required String authToken,
    required String loanRefCode,
  }) async {
    final response = await _tokenProvider.call(
      path: ApiPath.getSingleLoanApplication(loanRefCode),
      method: RequestMethod.get,
      options: Options(
        headers: ApiHeaders.requestHeaderWithToken(authToken),
      ),
    );

    final res = processData(
      (p0) => LoanApplicationGeneralResponse.fromJson(p0),
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

  Future<LoanApplicationGeneralResponse> updateLoanApplicationInitiated({
    required String authToken,
    required LoanApplicationInitiatedRequest request,
  }) async {
    final response = await _tokenProvider.call(
      path: ApiPath.updateLoanApplication,
      method: RequestMethod.post,
      body: request.toJson(),
      options: Options(
        headers: ApiHeaders.transactionRequestHeaderToken(authToken),
      ),
    );

    final res = processData(
      (p0) => LoanApplicationGeneralResponse.fromJson(p0),
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

  Future<LoanApplicationGeneralResponse> updateLoanApplicationGeneral({
    required String authToken,
    required LoanApplicationGeneralRequest request,
  }) async {
    final response = await _tokenProvider.call(
      path: ApiPath.updateLoanApplication,
      method: RequestMethod.post,
      body: request.toJson(),
      options: Options(
        headers: ApiHeaders.transactionRequestHeaderToken(authToken),
      ),
    );

    final res = processData(
      (p0) => LoanApplicationGeneralResponse.fromJson(p0),
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

  Future<LoanApplicationGeneralResponse> updateLoanApplicationAccept({
    required String authToken,
    required String transactionPin,
    required String deviceId,
    required LoanApplicationGeneralRequest request,
  }) async {
    final response = await _tokenProvider.call(
      path: ApiPath.updateLoanApplication,
      method: RequestMethod.post,
      body: request.toJson(),
      options: Options(
        headers: ApiHeaders.transactionRequestHeaderToken(
          authToken,
          transactionPin: transactionPin,
          xDeviceId: deviceId,
        ),
      ),
    );

    final res = processData(
      (p0) => LoanApplicationGeneralResponse.fromJson(p0),
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

  Future<LoanApplicationGeneralResponse> getLoanOfferLetter({
    required String authToken,
    required String loanRefCode,
  }) async {
    final response = await _tokenProvider.call(
      path: ApiPath.getLoanOfferPDFLink(loanRefCode),
      method: RequestMethod.get,
      options: Options(
        headers: ApiHeaders.requestHeaderWithToken(authToken),
      ),
    );

    final res = processData(
      (p0) => LoanApplicationGeneralResponse.fromJson(p0),
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
