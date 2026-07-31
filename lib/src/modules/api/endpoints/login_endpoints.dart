import 'package:dio/dio.dart';
import 'package:rex_app/src/modules/api/dio/api_headers.dart';
import 'package:rex_app/src/modules/api/dio/api_path.dart';
import 'package:rex_app/src/modules/api/dio/api_response.dart';
import 'package:rex_app/src/modules/api/models/encryption_check_payload.dart';
import 'package:rex_app/src/modules/api/rex_api.dart';

/// Status the backend returns for valid credentials sent from a location it
/// does not recognise yet. It comes back inside `data` while the envelope still
/// reports `success`, so it has to be checked on its own.
const _locationOtpRequired = 'location_otp_required';

bool _isLocationOtpRequired(LoginResponseData? data) {
  return data != null &&
      (data.requiresLocationOtp == true || data.status == _locationOtpRequired);
}

/// The challenge can also arrive on an error status code, in which case dio
/// throws before the body is parsed.
bool _isLocationOtpRequiredError(DioException e) {
  final body = e.response?.data;
  if (body is! Map) return false;
  final data = body['data'];
  if (data is! Map) return false;
  return data['requires_location_otp'] == true ||
      data['status'] == _locationOtpRequired;
}

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
      if (_isLocationOtpRequired(apiResponse.data)) {
        throw LocationOtpRequiredException(
          message: apiResponse.data?.message ?? apiResponse.message,
          status: _locationOtpRequired,
          otpToken: apiResponse.data?.otpToken ?? '',
        );
      }
      if (!apiResponse.isSuccess) {
        throw ApiException(
          message: apiResponse.message,
          status: apiResponse.status,
        );
      }
      return apiResponse.data!;
    } on DioException catch (e) {
      final errorMessage = mapDioExceptionToMessage(e);
      if (_isLocationOtpRequiredError(e)) {
        throw LocationOtpRequiredException(
          message: errorMessage,
          status: _locationOtpRequired,
          otpToken: e.response?.data['data']['otp_token'] ?? '',
        );
      }
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

  /// Clears the location challenge with the OTP the backend sent during login.
  /// The `otp_token` from that login response travels in the body and is what
  /// ties the OTP back to the pending session.
  Future<LoginResponseData> verifyLocationOtp({
    required HeaderNoAuthNoCrypt header,
    required VerifyLocationOtpRequest request,
  }) async {
    try {
      final response = await ApiLib.getDioInstance().post(
        ApiPath.verifyLocationOtp,
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

  Future<String> sendOtp({
    required HeaderNoAuthNoCrypt header,
    required SendOtpRequest request,
  }) async {
    try {
      final response = await ApiLib.getDioInstance().post(
        ApiPath.sendOtp,
        data: request.toJson(),
        options: Options(headers: ApiHeaders.noAuthNoCrypt(header)),
      );

      final apiResponse = ApiResponse<Object?>.fromJson(
        response.data,
        (_) => null,
      );
      if (!apiResponse.isSuccess) {
        throw ApiException(
          message: apiResponse.message,
          status: apiResponse.status,
        );
      }
      return apiResponse.message.toString();
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

  Future<String> resetPassword({
    required HeaderNoAuthNoCrypt header,
    required ResetPasswordRequest request,
  }) async {
    try {
      final response = await ApiLib.getDioInstance().post(
        ApiPath.passwordReset,
        data: request.toJson(),
        options: Options(headers: ApiHeaders.noAuthNoCrypt(header)),
      );

      final apiResponse = ApiResponse<Object?>.fromJson(
        response.data,
        (_) => null,
      );
      if (!apiResponse.isSuccess) {
        throw ApiException(
          message: apiResponse.message,
          status: apiResponse.status,
        );
      }
      return apiResponse.message.toString();
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
