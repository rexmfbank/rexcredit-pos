import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:rex_app/src/data/rex_api/rex_api.dart';
import '../../shared_models/api_headers.dart';
import '../../../exceptions/rex_api_exception.dart';
import '../../../utils/api_path.dart';

import '../../../exceptions/error_code.dart';

mixin InternalTSQ {
  Future<dynamic> performInternalTSQ({
    required String token,
    required InternalTSQRequest request,
  }) async {
    try {
      final dio = Dio()
        ..interceptors.add(PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          compact: false,
        ));
      final response = await dio.post(
        ApiPath.internalTSQ,
        data: request.toJson(),
        options:
            Options(headers: ApiHeaders.transactionRequestHeaderToken(token)),
      );
      var apiResponse = InternalTSQResponse.fromJson(response.data);
      if (apiResponse.responseCode == ErrorCode.SUCCESS) {
        return InternalTSQResponse.fromJson(response.data);
      }
      final errorData = ErrorData.fromJson(response.data);
      throw RexApiException(responseMessage: errorData.responseMessage);
    } catch (e, stackTrace) {
      print("Error => ${e.toString()}");
      print("Error Stack => $stackTrace");
      throw RexApiException(message: e.toString());
    }
  }
}
