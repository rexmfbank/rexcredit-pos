import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:rex_app/src/modules/revamp/utils/data/rex_api/rex_api.dart';
import '../../../utils/api_path.dart';

import '../../../exceptions/error_code.dart';
import '../../../exceptions/rex_api_exception.dart';
import '../../shared_models/api_headers.dart';

mixin UpdateDirectors {
  Future<AddDirectorsResponse> updateDirectors({
    required String token,
    required AddDirectorsRequest request,
    required int directorId,
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
        "${ApiPath.updateDirectors}$directorId",
        data: request.toJson(),
        options:
            Options(headers: ApiHeaders.transactionRequestHeaderToken(token)),
      );
      var apiResponse = AddDirectorsResponse.fromJson(response.data);
      if (apiResponse.responseCode == ErrorCode.SUCCESS) {
        return AddDirectorsResponse.fromJson(response.data);
      }

      throw RexApiException(responseMessage: apiResponse.responseMessage);
    } on DioException catch (e, _) {
      throw '$e';
    } catch (e, _) {
      throw RexApiException.defaultMessage();
    }
  }
}
