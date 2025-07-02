import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:rex_app/src/modules/revamp/utils/data/rex_api/rex_api.dart';
import '../../../shared_models/api_headers.dart';
import '../../../../exceptions/error_code.dart';
import '../../../../exceptions/rex_api_exception.dart';
import '../../../../utils/api_path.dart';

mixin StoreSecurityQuestion {
  Future<StoreSecurityQuestionResponse> storeSecurityQuestion({
    required String token,
    required StoreSecurityQuestionRequest request,
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
        ApiPath.saveSecurityQuestion,
        data: request.toJson(),
        options:
            Options(headers: ApiHeaders.transactionRequestHeaderToken(token)),
      );
      var apiResponse = StoreSecurityQuestionResponse.fromJson(response.data);
      if (apiResponse.responseCode == ErrorCode.SUCCESS) {
        return StoreSecurityQuestionResponse.fromJson(response.data);
      }

      throw RexApiException(responseMessage: apiResponse.responseMessage);
    } on DioException catch (e, stackTrace) {
      final rexException = RexApiException.defaultMessage();
      if (e.response == null) throw rexException;
      if (e.response!.data == null) throw rexException;
      print("Error Stack => $stackTrace");

      final errorJson = ErrorData.fromJson(e.response!.data);
      throw RexApiException(message: errorJson.responseMessage);
    } catch (e, stackTrace) {
      print("Error => ${e.toString()}");
      print("Error Stack => $stackTrace");
      throw RexApiException.defaultMessage();
    }
  }
}
