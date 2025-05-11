import 'package:equatable/equatable.dart';

class UserReferral extends Equatable {
  final String responseCode;
  final String responseMessage;
  final UserReferralData? data;

  const UserReferral({
    required this.responseCode,
    required this.responseMessage,
    this.data,
  });

  const UserReferral.empty()
      : responseCode = '',
        responseMessage = '',
        data = null;

  factory UserReferral.fromJson(Map<String, dynamic> json) => UserReferral(
        responseCode: json["responseCode"],
        responseMessage: json["responseMessage"],
        data: json["data"] == null
            ? null
            : UserReferralData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "responseCode": responseCode,
        "responseMessage": responseMessage,
        "data": data?.toJson(),
      };

  @override
  String toString() => {
        "CLASS": "UserReferrals",
        "responseCode": responseCode,
        "responseMessage": responseMessage,
        "data": data?.toJson(),
      }.toString();

  @override
  List<Object?> get props => [responseCode, responseMessage, data];
}

class UserReferralData extends Equatable {
  final List<ReferralResponse>? referralResponses;
  final num? totalEarning;

  const UserReferralData({
    this.referralResponses,
    this.totalEarning,
  });

  const UserReferralData.empty()
      : referralResponses = null,
        totalEarning = null;

  factory UserReferralData.fromJson(Map<String, dynamic> json) =>
      UserReferralData(
        referralResponses: json["referralResponses"] == null
            ? null
            : List<ReferralResponse>.from(
                json["referralResponses"]
                    .map((x) => ReferralResponse.fromJson(x)),
              ),
        totalEarning: json["totalEarning"],
      );

  Map<String, dynamic> toJson() => {
        "referralResponses": referralResponses?.map((x) => x.toJson()).toList(),
        "totalEarning": totalEarning,
      };

  @override
  List<Object?> get props => [referralResponses, totalEarning];
}

class ReferralResponse extends Equatable {
  final String? referralCode;
  final String? status;
  final String? referredUsername;

  const ReferralResponse({
    this.referralCode,
    this.status,
    this.referredUsername,
  });

  const ReferralResponse.empty()
      : referralCode = null,
        status = null,
        referredUsername = null;

  factory ReferralResponse.fromJson(Map<String, dynamic> json) =>
      ReferralResponse(
        referralCode: json["referralCode"],
        status: json["status"],
        referredUsername: json["referredUsername"],
      );

  Map<String, dynamic> toJson() => {
        "referralCode": referralCode,
        "status": status,
        "referredUsername": referredUsername,
      };

  @override
  String toString() => {
        "CLASS": "ReferralResponse",
        "referralCode": referralCode,
        "status": status,
        "referredUsername": referredUsername,
      }.toString();

  @override
  List<Object?> get props => [referralCode, status, referredUsername];
}
