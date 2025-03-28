import 'package:rex_api/src/endpoints/inventory/make_a_sale/response/customer_response_model.dart';

class CreateCustomerResponse {
  final String? responseCode;
  final String? responseMessage;
  final CustomerModel? data;

  CreateCustomerResponse({
    this.responseCode,
    this.responseMessage,
    this.data,
  });

  factory CreateCustomerResponse.fromJson(Map<String, dynamic> json) => CreateCustomerResponse(
    responseCode: json["responseCode"],
    responseMessage: json["responseMessage"],
    data: json["data"] == null ? null : CustomerModel.fromJson(json["data"]),
  );
}
