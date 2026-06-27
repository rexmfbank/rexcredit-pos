import 'package:dio/dio.dart';
import 'package:rex_app/src/modules/api/dio/api_headers.dart';
import 'package:rex_app/src/modules/api/dio/api_path.dart';
import 'package:rex_app/src/modules/api/dio/api_response.dart';
import 'package:rex_app/src/modules/api/models/encryption_check_payload.dart';
import 'package:rex_app/src/modules/api/rex_api.dart';

mixin LoginEndpoints {
  Future<EncryptCheck> checkEncryption() async {
    try {
      final response = await ApiLib.getDioInstance().get(
        ApiPath.checkEncryption,
      );
      return EncryptCheck.fromJson(response.data);
    } on DioException catch (e) {
      final errorMessage = mapDioExceptionToMessage(e);
      throw ApiException(
        message: errorMessage,
        status: "${e.response?.statusCode}",
      );
    } catch (err) {
      if (err is ApiException) rethrow;
      throw ApiException(
        message: 'An unexpected error occurred: $err',
        status: '0',
      );
    }
  }

  Future<LoginResponseData> login({
    required HeaderNoAuthNoCrypt header,
    required LoginRequest request,
  }) async {
    try {
      final response = await ApiLib.getDioInstance().post(
        ApiPath.login,
        data: request.toJson(),
        options: Options(headers: ApiHeaders.noAuthNoCrypt(header)),
      );

      final apiResponse = ApiResponse<LoginResponseData>.fromJson(
        response.data,
        (data) => LoginResponseData.fromJson(data),
      );
      if (!apiResponse.isSuccess) {
        throw ApiException(
          message: apiResponse.message,
          status: apiResponse.status,
        );
      }
      return apiResponse.data!;
    } on DioException catch (e) {
      final errorMessage = mapDioExceptionToMessage(e);
      throw ApiException(
        message: errorMessage,
        status: "${e.response?.statusCode}",
      );
    } catch (err) {
      if (err is ApiException) rethrow;
      throw ApiException(
        message: 'An unexpected error occurred: $err',
        status: '0',
      );
    }
  }

  Future<ProfileResData> profile({
    required HeaderWithAuthNoCrypt header,
  }) async {
    try {
      final response = await ApiLib.getDioInstance().get(
        ApiPath.profile,
        options: Options(headers: ApiHeaders.withAuthNoCrypt(header)),
      );

      final apiResponse = ApiResponse<ProfileResData>.fromJson(
        response.data,
        (data) => ProfileResData.fromJson(data),
      );
      if (!apiResponse.isSuccess) {
        throw ApiException(
          message: apiResponse.message,
          status: apiResponse.status,
        );
      }
      return apiResponse.data!;
    } on DioException catch (e) {
      final errorMessage = mapDioExceptionToMessage(e);
      throw ApiException(
        message: errorMessage,
        status: "${e.response?.statusCode}",
      );
    } catch (err) {
      if (err is ApiException) rethrow;
      throw ApiException(
        message: 'An unexpected error occurred: $err',
        status: '0',
      );
    }
  }
}
