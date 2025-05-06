import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:rex_app/src/data/rex_api/rex_api.dart';
import '../../../utils/api_path.dart';

import '../../../exceptions/error_code.dart';
import '../../../exceptions/rex_api_exception.dart';
import '../../shared_models/api_headers.dart';

mixin GetDirectors {
  Future<GetDirectorsResponse> getDirectors({
    required String token,
    required String businessCode,
  }) async {
    try {
      final dio = Dio()
        ..interceptors.add(PrettyDioLogger(
          requestHeader: true,
          responseBody: true,
          compact: false,
        ));
      final response = await dio.get(
        ApiPath.getDirectors,
        queryParameters: {"businessCode": businessCode},
        options: Options(headers: ApiHeaders.requestHeaderWithToken(token)),
      );
      var apiResponse = GetDirectorsResponse.fromJson(response.data);
      if (apiResponse.responseCode == ErrorCode.SUCCESS) {
        return apiResponse;
      }

      throw RexApiException(responseMessage: apiResponse.responseMessage);
    } on DioException catch (e, stackTrace) {
      print("Error Response => ${e.response}");
      print("Error Data => ${e.response!.data}");
      print("Status Code => ${e.response!.statusCode}");
      print("Error Stack => $stackTrace");

      throw '$e';
    } catch (e, stackTrace) {
      print("Error => ${e.toString()}");
      print("Error Stack => $stackTrace");
      throw RexApiException(message: e.toString());
    }
  }
}
