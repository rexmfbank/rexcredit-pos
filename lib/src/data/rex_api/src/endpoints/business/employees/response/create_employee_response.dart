import 'get_employee_response.dart';

class CreateEmployeeResponse {
  final String responseCode;
  final String responseMessage;
  final String? entityCode;
  final EmployeeInfoDTO? data;

  CreateEmployeeResponse({
    required this.responseCode,
    required this.responseMessage,
    this.entityCode,
    this.data,
  });

  factory CreateEmployeeResponse.fromJson(Map<String, dynamic> json) => CreateEmployeeResponse(
    responseCode: json["responseCode"],
    responseMessage: json["responseMessage"],
    entityCode: json["entityCode"],
    data: json["data"] == null ? null : EmployeeInfoDTO.fromJson(json["data"]),
  );
}