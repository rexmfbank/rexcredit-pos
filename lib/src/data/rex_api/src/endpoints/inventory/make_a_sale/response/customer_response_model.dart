class CustomerResponseModel {
  final String? responseCode;
  final String? responseMessage;
  final List<CustomerModel>? data;

  CustomerResponseModel({
    this.responseCode,
    this.responseMessage,
    this.data,
  });

  factory CustomerResponseModel.fromJson(Map<String, dynamic> json) => CustomerResponseModel(
    responseCode: json["responseCode"],
    responseMessage: json["responseMessage"],
    data:json["data"] == null ? [] : (json["data"] as List).map((e) => CustomerModel.fromJson(e)).toList(),
  );
}

class CustomerModel {
  final String? name;
  final String? customerId;
  final String? email;
  final String? phone;

  CustomerModel({
    this.name,
    this.customerId,
    this.email,
    this.phone,
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) => CustomerModel(
    name: json["name"],
    customerId: json["customerId"],
    email: json["email"],
    phone: json["phone"],
  );
}
