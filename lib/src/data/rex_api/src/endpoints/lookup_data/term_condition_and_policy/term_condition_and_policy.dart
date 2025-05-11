import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:rex_app/src/data/rex_api/rex_api.dart';
import '../../shared_models/api_headers.dart';
import '../../../exceptions/rex_api_exception.dart';
import '../../../utils/api_path.dart';

import '../../../exceptions/error_code.dart';

mixin TermsConditionsAndPolicy {
  Future<dynamic> getTermsConditionsAndPolicy({
    required String token,
  }) async {
    try {
      final dio = Dio()
        ..interceptors.add(PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          compact: false,
        ));
      final response = await dio.get(
        ApiPath.termsConditionAndPolicy,
        options:
            Options(headers: ApiHeaders.transactionRequestHeaderToken(token)),
      );
      var apiResponse =
          TermsConditionsAndPolicyResponse.fromJson(response.data);
      if (apiResponse.responseCode == ErrorCode.SUCCESS) {
        return apiResponse;
      }
      throw RexApiException(responseMessage: apiResponse.responseMessage);
    } catch (e, stackTrace) {
      print("Error => ${e.toString()}");
      print("Error Stack => $stackTrace");
      throw RexApiException(message: e.toString());
    }
  }
}
