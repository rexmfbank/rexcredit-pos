import 'package:dio/dio.dart';
import 'package:rex_app/src/modules/api/dio/api_headers.dart';
import 'package:rex_app/src/modules/api/dio/api_path.dart';
import 'package:rex_app/src/modules/api/dio/api_response.dart';
import 'package:rex_app/src/modules/api/models/name_inquiry_payload.dart';
import 'package:rex_app/src/modules/api/rex_api.dart';

mixin TransferEndpoints {
  Future<NameInquiryData> nameInquiry({
    required HeaderWithAuthNoCrypt header,
    required NameInquiryRequest request,
  }) async {
    try {
      final response = await ApiLib.getDioInstance().post(
        ApiPath.nameInquiry,
        data: request.toJson(),
        options: Options(headers: ApiHeaders.withAuthNoCrypt(header)),
      );

      final apiResponse = ApiResponse<NameInquiryData>.fromJson(
        response.data,
        (data) => NameInquiryData.fromJson(data),
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

  Future<SendMoneyResponseData> sendMoney({
    required HeaderWithAuthNoCrypt header,
    required SendMoneyRequest request,
  }) async {
    try {
      final response = await ApiLib.getDioInstance().post(
        ApiPath.sendMoney,
        data: request.toJson(),
        options: Options(headers: ApiHeaders.withAuthNoCrypt(header)),
      );

      final apiResponse = ApiResponse<SendMoneyResponseData>.fromJson(
        response.data,
        (data) => SendMoneyResponseData.fromJson(data),
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

  Future<BalanceData> balance({required HeaderWithAuthNoCrypt header}) async {
    final response = await ApiLib.getDioInstance().get(
      ApiPath.balance,
      options: Options(headers: ApiHeaders.withAuthNoCrypt(header)),
    );
    try {
      final apiResponse = ApiResponse<BalanceData>.fromJson(
        response.data,
        (data) => BalanceData.fromJson(data),
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

  Future<TData> transactionHistory({
    required HeaderWithAuthNoCrypt header,
    required TransHistoryRequest request,
  }) async {
    final response = await ApiLib.getDioInstance().post(
      ApiPath.getTransactions,
      data: request.toJson(),
      options: Options(headers: ApiHeaders.withAuthNoCrypt(header)),
    );
    try {
      final apiResponse = ApiResponse<TData>.fromJson(
        response.data,
        (data) => TData.fromJson(data),
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

  Future<List<BankData>> bankList({
    required HeaderWithAuthNoCrypt header,
  }) async {
    final response = await ApiLib.getDioInstance().get(
      ApiPath.bankList,
      options: Options(headers: ApiHeaders.withAuthNoCrypt(header)),
    );
    try {
      final apiResponse = ApiResponse<List<BankData>>.fromJson(
        response.data,
        (data) =>
            (data as List<dynamic>).map((e) => BankData.fromJson(e)).toList(),
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
