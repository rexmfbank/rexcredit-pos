import 'package:dio/dio.dart';
import 'package:rex_api/rex_api.dart';
import 'package:rex_api/src/exceptions/rex_api_exception.dart';
import 'package:rex_api/src/utils/api_path.dart';

mixin GetLocalGovt {
  Future<List<LocalGovtData>> getLocalGovt({
    required int stateId,
    required String authToken,
  }) async {
    try {
      final dio = Dio();
      final response = await dio.get(
        '${ApiPath.lga}$stateId',
        options: Options(headers: {"Authorization": "Bearer $authToken"}),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final apiResponse = GetLocalGovtResponse.fromJson(response.data);
        return apiResponse.data;
      }
      final errorData = ErrorData.fromJson(response.data);
      throw RexApiException(message: errorData.responseMessage);
    } on DioException catch (e, stackTrace) {
      print("Error Response => ${e.response}");
      print("Error Data => ${e.response!.data}");
      print("Error Stack => $stackTrace");

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
