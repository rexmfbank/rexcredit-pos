import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:rex_api/rex_api.dart';
import 'package:rex_api/src/utils/api_path.dart';

import '../../../exceptions/error_code.dart';
import '../../../exceptions/rex_api_exception.dart';
import '../../shared_models/api_headers.dart';

mixin UpdateDirectors {
  Future<AddDirectorsResponse> updateDirectors(
      {required String token,
      required AddDirectorsRequest request,
      required int directorId}) async {
    try {
      final dio = Dio()
        ..interceptors.add(PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          compact: false,
        ));
      final response = await dio.post(
        "${ApiPath.updateDirectors}$directorId",
        data: request.toJson(),
        options: Options(headers: ApiHeaders.transactionRequestHeaderToken(token)),
      );
      var apiResponse = AddDirectorsResponse.fromJson(response.data);
      if (apiResponse.responseCode == ErrorCode.SUCCESS) {
        return AddDirectorsResponse.fromJson(response.data);
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
      throw RexApiException.defaultMessage();
    }
  }
}
