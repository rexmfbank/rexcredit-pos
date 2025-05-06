import 'package:rex_app/src/data/rex_api/rex_api.dart';

class GetEmployeeResponse {
  final String responseCode;
  final String responseMessage;
  final String? entityCode;
  final List<EmployeeInfoDTO>? data;
  final int? pageIndex;
  final int? pageSize;
  final int? totalPages;
  final int? totalCount;

  GetEmployeeResponse({
    required this.responseCode,
    required this.responseMessage,
    this.entityCode,
    this.data,
    this.pageIndex,
    this.pageSize,
    this.totalPages,
    this.totalCount,
  });

  factory GetEmployeeResponse.fromJson(Map<String, dynamic> json) =>
      GetEmployeeResponse(
        responseCode: json["responseCode"],
        responseMessage: json["responseMessage"],
        entityCode: json["entityCode"],
        data: json["data"] == null
            ? []
            : (json["data"] as List)
                .map((e) => EmployeeInfoDTO.fromJson(e))
                .toList(),
        pageIndex: json["pageIndex"] ?? 0,
        pageSize: json["pageSize"] ?? 0,
        totalPages: json["totalPages"] ?? 0,
        totalCount: json["totalCount"] ?? 0,
      );
}

class EmployeeInfoDTO {
  final String? businessStaffCode;
  final String? entityCode;
  final String? firstname;
  final String? lastname;
  final String? email;
  final String? department;
  final String? designation;
  final String? businessCode;
  final String? paymentGroup;
  final String? salaryCurrency;
  final double? monthlyGross;
  final String? photoLink;
  final String? phone;
  final String? bankName;
  final String? accountName;
  final String? accountNumber;
  final String? swiftCode;
  final List<PayrollItem>? payrollItems;

  EmployeeInfoDTO({
    this.businessStaffCode,
    this.entityCode,
    this.firstname,
    this.lastname,
    this.email,
    this.department,
    this.designation,
    this.businessCode,
    this.paymentGroup,
    this.salaryCurrency,
    this.monthlyGross,
    this.photoLink,
    this.phone,
    this.bankName,
    this.accountName,
    this.accountNumber,
    this.swiftCode,
    this.payrollItems,
  });

  factory EmployeeInfoDTO.fromJson(Map<String, dynamic> json) =>
      EmployeeInfoDTO(
        businessStaffCode: json["businessStaffCode"] ?? '',
        entityCode: json["entityCode"] ?? '',
        firstname: json["firstname"] ?? '',
        lastname: json["lastname"] ?? '',
        email: json["email"] ?? '',
        department: json["department"] ?? '',
        designation: json["designation"] ?? '',
        businessCode: json["businessCode"] ?? '',
        paymentGroup: json["paymentGroup"] ?? '',
        salaryCurrency: json["salaryCurrency"] ?? '',
        monthlyGross: json["monthlyGross"] ?? 0,
        photoLink: json["photoLink"] ?? '',
        phone: json["phone"] ?? '',
        bankName: json["bankName"] ?? '',
        accountName: json["accountName"] ?? '',
        accountNumber: json["accountNumber"] ?? '',
        swiftCode: json["swiftCode"] ?? '',
        payrollItems: json["payrollItems"] == null
            ? []
            : (json["payrollItems"] as List)
                .map((e) => PayrollItem.fromJson(e))
                .toList(),
      );
}
