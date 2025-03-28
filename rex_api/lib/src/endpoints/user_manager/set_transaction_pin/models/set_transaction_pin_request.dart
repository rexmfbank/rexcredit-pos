import 'package:equatable/equatable.dart';

class SetTransactionPinRequest extends Equatable {
  final String pin;
  final String username;
  final String entityCode;

  const SetTransactionPinRequest({
    required this.pin,
    required this.username,
    required this.entityCode,
  });

  Map<String, dynamic> toJson() => {
        "pin": pin,
        "username": username,
        "entityCode": entityCode,
      };

  @override
  String toString() => {
        "CLASS": "SetTransactionPinRequest",
        "pin": pin,
        "username": username,
        "entityCode": entityCode,
      }.toString();

  @override
  List<Object?> get props => [pin, username, entityCode];
}
