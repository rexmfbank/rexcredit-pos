class AccountInfo {
  String responseCode;
  String responseMessage;
  AccountData data;

  AccountInfo({
    required this.responseCode,
    required this.responseMessage,
    required this.data,
  });

  factory AccountInfo.fromJson(Map<String, dynamic> json) => AccountInfo(
        responseCode: json["responseCode"],
        responseMessage: json["responseMessage"],
        data: AccountData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "responseCode": responseCode,
        "responseMessage": responseMessage,
        "data": data.toJson(),
      };
}

class AccountData {
  String accountNumber;
  String name;

  AccountData({
    required this.accountNumber,
    required this.name,
  });

  factory AccountData.fromJson(Map<String, dynamic> json) => AccountData(
        accountNumber: json["accountNumber"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "accountNumber": accountNumber,
        "name": name,
      };
}
