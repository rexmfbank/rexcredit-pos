import 'package:equatable/equatable.dart';

class ChangePinResponse extends Equatable {
  final String responseCode;
  final String responseMessage;
  final String? id;
  final String? refNo;

  ChangePinResponse({
    required this.responseCode,
    required this.responseMessage,
    this.id,
    this.refNo
  });

  ChangePinResponse.empty()
      : responseCode = '',
        responseMessage = '',
        id = '',
        refNo = '';

  factory ChangePinResponse.fromJson(Map<String, dynamic> json) {
    return ChangePinResponse(
      responseCode: json['responseCode'] as String,
      responseMessage: json['responseMessage'] as String,
      id: json["id"],
      refNo: json['refNo']
    );
  }

  @override
  List<Object?> get props => [];
}
