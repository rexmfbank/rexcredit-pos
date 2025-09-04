import 'package:equatable/equatable.dart';

class RetrieveRrnResponse extends Equatable {
  final String responseCode;
  final String responseMessage;
  final dynamic entityCode;
  final RetrieveRrnData data;

  const RetrieveRrnResponse({
    required this.responseCode,
    required this.responseMessage,
    this.entityCode,
    required this.data,
  });

  factory RetrieveRrnResponse.fromJson(Map<String, dynamic> json) {
    return RetrieveRrnResponse(
      responseCode: json['responseCode'] as String,
      responseMessage: json['responseMessage'] as String,
      entityCode: json['entityCode'],
      data: RetrieveRrnData.fromJson(json['data'] as Map<String, dynamic>),
    );
  }

  @override
  List<Object?> get props => [responseCode, responseMessage, entityCode, data];
}

class RetrieveRrnData extends Equatable {
  final String rrn;
  const RetrieveRrnData({required this.rrn});

  factory RetrieveRrnData.fromJson(Map<String, dynamic> json) =>
      RetrieveRrnData(rrn: json['rrn'] as String);

  @override
  List<Object?> get props => [rrn];
}
