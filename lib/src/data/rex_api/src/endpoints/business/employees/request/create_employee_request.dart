class CreateEmployeeRequest {
  final String businessCode;
  final String? staffCode;
  final String entityCode;
  final String firstname;
  final String lastname;
  final String phone;
  final String photoLink;
  final String email;
  final String department;
  final String? paymentGroup;
  final String designation;
  final String salaryCurrency;
  final double monthlyGross;
  final String bankName;
  final String accountName;
  final String accountNumber;
  final String swiftCode;
  final List<PayrollItem> payrollItems;

  CreateEmployeeRequest({
    required this.businessCode,
    required this.entityCode,
    required this.firstname,
    required this.lastname,
    required this.phone,
    required this.photoLink,
    required this.email,
    required this.department,
    required this.designation,
    required this.salaryCurrency,
    required this.monthlyGross,
    required this.bankName,
    required this.accountName,
    required this.accountNumber,
    required this.swiftCode,
    required this.payrollItems,
    this.paymentGroup,
    this.staffCode,
  });

  Map<String, dynamic> toJson() => {
    "businessCode": businessCode,
    "staffCode": staffCode,
    "entityCode": entityCode,
    "firstname": firstname,
    "lastname": lastname,
    "phone": phone,
    "photoLink": photoLink,
    "email": email,
    "department": department,
    "paymentGroup": paymentGroup,
    "designation": designation,
    "salaryCurrency": salaryCurrency,
    "monthlyGross": monthlyGross,
    "bankName": bankName,
    "accountName": accountName,
    "accountNumber": accountNumber,
    "swiftCode": swiftCode,
    "payrollItems": List<dynamic>.from(payrollItems.map((x) => x.toJson())),
  };
}

class PayrollItem {
  final String? itemCode;
  final String? staffCode;
  final String? type;
  final String? title;
  final double? amount;

  PayrollItem({
     this.itemCode,
     this.staffCode,
     this.type,
     this.title,
     this.amount,
  });

  factory PayrollItem.fromJson(Map<String, dynamic> json) =>
      PayrollItem(
        itemCode: json["itemCode"],
        staffCode: json["staffCode"],
        type: json["type"],
        title: json["title"],
        amount: json["amount"],
      );

  Map<String, dynamic> toJson() => {
    "itemCode": itemCode,
    "staffCode": staffCode,
    "type": type,
    "title": title,
    "amount": amount,
  };
}
