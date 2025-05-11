import 'package:equatable/equatable.dart';

class UpdateAddressResponse extends Equatable {
  final String responseCode;
  final String responseMessage;
  final String? id;
  final String? refNo;

  UpdateAddressResponse({
    required this.responseCode,
    required this.responseMessage,
    this.id,
    this.refNo
  });

  UpdateAddressResponse.empty()
      : responseCode = '',
        responseMessage = '',
        id = '',
        refNo = '';

  factory UpdateAddressResponse.fromJson(Map<String, dynamic> json) {
    return UpdateAddressResponse(
      responseCode: json['responseCode'] as String,
      responseMessage: json['responseMessage'] as String,
      id: json["id"],
      refNo: json['refNo']
    );
  }

  @override
  List<Object?> get props => [
    responseCode,
    responseMessage,
  ];
}
