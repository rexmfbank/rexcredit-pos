import 'package:equatable/equatable.dart';

class ResetTransactionPinRequest extends Equatable {
  final String otp;
  final String mobileNumber;
  final String username;
  final String entityCode;
  final String transactionPin;

  const ResetTransactionPinRequest({
    required this.otp,
    required this.mobileNumber,
    required this.username,
    required this.entityCode,
    required this.transactionPin,
  });

  Map<String, dynamic> toJson() => {
        "otp": otp,
        "mobileNo": mobileNumber,
        "username": username,
        "entityCode": entityCode,
        "transactionPin": transactionPin
      };

  @override
  String toString() => {
        "CLASS": "ResetTransactionPinRequest",
        "otp": otp,
        "mobileNo": mobileNumber,
        "username": username,
        "entityCode": entityCode,
        "transactionPin": transactionPin
      }.toString();

  @override
  List<Object?> get props => [
        otp,
        mobileNumber,
        username,
        entityCode,
        transactionPin,
      ];
}
