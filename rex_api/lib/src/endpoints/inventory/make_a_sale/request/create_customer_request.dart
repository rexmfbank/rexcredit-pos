class CreateCustomerRequest {
  final String name;
  final String customerId;
  final String email;
  final String phone;

  CreateCustomerRequest({
    required this.name,
    required this.customerId,
    required this.email,
    required this.phone,
  });

  Map<String, dynamic> toJson() => {
    "name": name,
    "customerId": customerId,
    "email": email,
    "phone": phone,
  };
}
