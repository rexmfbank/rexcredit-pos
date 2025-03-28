import 'package:dio/dio.dart';
import 'package:rex_api/src/endpoints/business/employees/request/create_employee_request.dart';
import 'package:rex_api/src/endpoints/business/employees/request/get_all_employees_query.dart';
import 'package:rex_api/src/endpoints/business/employees/response/create_employee_response.dart';
import 'package:rex_api/src/endpoints/business/employees/response/get_employee_response.dart';
import 'package:rex_api/src/endpoints/shared_models/api_headers.dart';
import 'package:rex_api/src/endpoints/utility/response/rex_response_template.dart';
import 'package:rex_api/src/exceptions/data_transformer.dart';
import 'package:rex_api/src/exceptions/rex_api_exception.dart';
import 'package:rex_api/src/exceptions/string_constants.dart';
import 'package:rex_api/src/utils/api_path.dart';
import 'package:rex_api/src/utils/dio_network_provider.dart';

mixin EmployeeApi{
  static final _tokenProvider = AppNetworkProvider();

  Future<GetEmployeeResponse> getEmployees({
    required String authToken, required GetAllEmployeesQuery query,
  }) async {
    final response = await _tokenProvider.call(
      path: ApiPath.getAllEmployees,
      method: RequestMethod.get,
      queryParams: query.toJson(),
      options: Options(
        headers: ApiHeaders.transactionRequestHeaderToken(authToken),
      ),
    );

    final res = processData((p0) => GetEmployeeResponse.fromJson(p0), response);
    res.either(
          (left) => throw RexApiException(
          message: res.left.responseMessage ?? StringConstants.exceptionMessage),
          (right) => _tokenProvider.parseResponse(
        responseCode: res.isRight ? res.right.responseCode : '',
        errorAction: () =>
        throw RexApiException(message: res.right.responseMessage),
      ),
    );

    return res.right;
  }

  Future<CreateEmployeeResponse> createEmployee({
    required String authToken, required CreateEmployeeRequest request,
  }) async {
    final response = await _tokenProvider.call(
      path: ApiPath.registerEmployee,
      method: RequestMethod.post,
      body: request.toJson(),
      options: Options(
        headers: ApiHeaders.transactionRequestHeaderToken(authToken),
      ),
    );

    final res = processData((p0) => CreateEmployeeResponse.fromJson(p0), response);
    res.either(
          (left) => throw RexApiException(
          message: res.left.responseMessage ?? StringConstants.exceptionMessage),
          (right) => _tokenProvider.parseResponse(
        responseCode: res.isRight ? res.right.responseCode : '',
        errorAction: () =>
        throw RexApiException(message: res.right.responseMessage),
      ),
    );

    return res.right;
  }

  Future<CreateEmployeeResponse> updateEmployee({
    required String authToken, required CreateEmployeeRequest request,
  }) async {
    final response = await _tokenProvider.call(
      path: ApiPath.updateEmployee,
      method: RequestMethod.post,
      body: request.toJson(),
      options: Options(
        headers: ApiHeaders.transactionRequestHeaderToken(authToken),
      ),
    );

    final res = processData((p0) => CreateEmployeeResponse.fromJson(p0), response);
    res.either(
          (left) => throw RexApiException(
          message: res.left.responseMessage ?? StringConstants.exceptionMessage),
          (right) => _tokenProvider.parseResponse(
        responseCode: res.isRight ? res.right.responseCode : '',
        errorAction: () =>
        throw RexApiException(message: res.right.responseMessage),
      ),
    );

    return res.right;
  }

  Future<RexResponseTemplate> deleteEmployee({
    required String authToken, required String staffCode,
  }) async {
    final response = await _tokenProvider.call(
      path: ApiPath.deleteEmployee(staffCode),
      method: RequestMethod.post,
      options: Options(
        headers: ApiHeaders.transactionRequestHeaderToken(authToken),
      ),
    );

    final res = processData((p0) => RexResponseTemplate.fromJson(p0), response);
    res.either(
          (left) => throw RexApiException(
          message: res.left.responseMessage ?? StringConstants.exceptionMessage),
          (right) => _tokenProvider.parseResponse(
        responseCode: res.isRight ? res.right.responseCode! : '',
        errorAction: () =>
        throw RexApiException(message: res.right.responseMessage),
      ),
    );

    return res.right;
  }
}