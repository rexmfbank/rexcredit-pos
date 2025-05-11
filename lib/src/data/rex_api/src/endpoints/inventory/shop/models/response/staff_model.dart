class StaffModel {
  final String? name;
  final String? staffId;
  final String? email;
  final String? phone;
  final String? role;

  StaffModel({
    this.name,
    this.staffId,
    this.email,
    this.phone,
    this.role,
  });

  factory StaffModel.fromJson(Map<String, dynamic> json) => StaffModel(
    name: json["name"],
    staffId: json["staffId"],
    email: json["email"],
    phone: json["phone"],
    role: json["role"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "staffId": staffId,
    "email": email,
    "phone": phone,
    "role": role,
  };
}
