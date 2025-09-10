import 'package:equatable/equatable.dart';
import 'package:rex_app/src/modules/revamp/data/rex_api/rex_api.dart';

class GetLocalGovtResponse extends Equatable {
  final String status;
  final String message;
  final List<LocalGovtData> data;

  const GetLocalGovtResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory GetLocalGovtResponse.fromJson(Map<String, dynamic> json) {
    return GetLocalGovtResponse(
      status: json['status'] as String,
      message: json['message'] as String,
      data: List.from(
        json['data'].map((e) => LocalGovtData.fromJson(e)),
      ),
    );
  }

  @override
  String toString() => {
        "CLASS": "GetLocalGovtResponse",
        "status": status,
        "message": message,
        "data": data,
      }.toString();

  @override
  List<Object?> get props => [
        status,
        message,
        data,
      ];
}
