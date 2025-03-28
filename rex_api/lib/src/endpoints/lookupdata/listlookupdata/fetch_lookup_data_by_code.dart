import 'package:dio/dio.dart';
import 'package:rex_api/rex_api.dart';
import 'package:rex_api/src/exceptions/data_transformer.dart';
import 'package:rex_api/src/utils/api_path.dart';
import 'package:rex_api/src/utils/dio_network_provider.dart';
import '../../../exceptions/rex_api_exception.dart';
import 'package:rex_api/src/exceptions/string_constants.dart';
import '../../shared_models/api_headers.dart';

mixin FetchLookupData {
  static final _tokenProvider = AppNetworkProvider();

  Future<FetchLookupDataByCodeResponse> fetchRegisterlookupDataByCode({
    required String lookupCode,
    String entityCode = '',
    String parentCode = '',
  }) async {
    final response = await _tokenProvider.call(
      path: ApiPath.fetchlookupDataByCode,
      method: RequestMethod.get,
      queryParams: {
        "entityCode": entityCode,
        "lookupCode": lookupCode,
        "parentCode": parentCode
      },
      options: Options(headers: ApiHeaders.requestHeader),
    );

    final res = processData(
        (p0) => FetchLookupDataByCodeResponse.fromJson(p0), response);
    res.either(
      (left) => throw RexApiException(
          message: res.left.responseMessage ?? StringConstants.exceptionMessage),
      (right) => _tokenProvider.parseResponse(
        responseCode: res.isRight ? res.right.responseCode : '',
        errorAction: () =>
            throw RexApiException(message: res.right.responseMessage),
      ),
    );

    return res.right;
  }

  Future<FetchLookupDataByCodeResponse> fetchlookupDataByCode({
    required String authToken,
    required String lookupCode,
    String entityCode = '',
    String parentCode = '',
  }) async {
    final response = await _tokenProvider.call(
      path: ApiPath.fetchlookupDataByCode,
      method: RequestMethod.get,
      queryParams: {
        "entityCode": entityCode,
        "lookupCode": lookupCode,
        "parentCode": parentCode
      },
      options:
          Options(headers: ApiHeaders.transactionRequestHeaderToken(authToken)),
    );

    final res = processData(
        (p0) => FetchLookupDataByCodeResponse.fromJson(p0), response);
    res.either(
      (left) => throw RexApiException(
          message: res.left.responseMessage ?? StringConstants.exceptionMessage),
      (right) => _tokenProvider.parseResponse(
        responseCode: res.isRight ? res.right.responseCode : '',
        errorAction: () =>
            throw RexApiException(message: res.right.responseMessage),
      ),
    );

    return res.right;
  }

  Future<LookUpListDataResponse> fetchBaLookupData(
      {required String authToken, required LookupListQuery query}) async {
    final response = await _tokenProvider.call(
      path: ApiPath.fetchLookupListData,
      method: RequestMethod.get,
      queryParams: query.toJson(),
      options:
          Options(headers: ApiHeaders.transactionRequestHeaderToken(authToken)),
    );

    final res =
        processData((p0) => LookUpListDataResponse.fromJson(p0), response);
    res.either(
      (left) => throw RexApiException(
          message: res.left.responseMessage ?? StringConstants.exceptionMessage),
      (right) => _tokenProvider.parseResponse(
        responseCode: res.isRight ? res.right.responseCode : '',
        errorAction: () =>
            throw RexApiException(message: res.right.responseMessage),
      ),
    );

    return res.right;
  }
}
