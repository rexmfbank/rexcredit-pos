import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:rex_app/src/modules/revamp/utils/data/rex_api/rex_api.dart';
import '../../../shared_models/api_headers.dart';
import '../../../../exceptions/error_code.dart';
import '../../../../exceptions/rex_api_exception.dart';
import '../../../../utils/api_path.dart';

mixin ViewSecurityQuestion {
  Future<ViewSecurityQuestionResponse> viewSecurityQuestion({
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
        ApiPath.viewSecurityQuestion,
        options:
            Options(headers: ApiHeaders.transactionRequestHeaderToken(token)),
      );
      var apiResponse = ViewSecurityQuestionResponse.fromJson(response.data);
      if (apiResponse.responseCode == ErrorCode.SUCCESS) {
        return ViewSecurityQuestionResponse.fromJson(response.data);
      }

      final errorData = ErrorData.fromJson(response.data);
      throw RexApiException(responseMessage: errorData.responseMessage);
    } on DioException catch (e) {
      final rexException = RexApiException.defaultMessage();
      if (e.response == null) throw rexException;
      if (e.response!.data == null) throw rexException;

      final errorJson = ErrorData.fromJson(e.response!.data);
      throw RexApiException(message: errorJson.responseMessage);
    } catch (e, stackTrace) {
      print("Error => ${e.toString()}");
      print("Error Stack => $stackTrace");
      throw RexApiException.defaultMessage();
    }
  }
}
