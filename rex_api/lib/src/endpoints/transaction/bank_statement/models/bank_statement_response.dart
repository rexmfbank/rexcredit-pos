import 'package:equatable/equatable.dart';

class BankStatementResponse extends Equatable {
  final String responseCode;
  final String responseMessage;

  const BankStatementResponse({
    required this.responseCode,
    required this.responseMessage,
  });

  factory BankStatementResponse.fromJson(Map<String, dynamic> json) {
    return BankStatementResponse(
      responseCode: json['responseCode'],
      responseMessage: json['responseMessage'],
    );
  }

  @override
  List<Object?> get props => [
        responseCode,
        responseMessage,
      ];
}
