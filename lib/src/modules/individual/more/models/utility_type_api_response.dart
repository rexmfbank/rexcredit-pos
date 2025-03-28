import 'package:equatable/equatable.dart';
import 'package:rex_app/src/modules/individual/more/models/utility_type.dart';

class UtilityTypeApiResponse extends Equatable {
  final List<UtilityType> data;
  final String message;
  final String status;

  const UtilityTypeApiResponse({
    required this.data,
    required this.message,
    required this.status,
  });

  const UtilityTypeApiResponse.empty()
      : data = const [],
        message = '',
        status = '';

  factory UtilityTypeApiResponse.fromJson(Map<String, dynamic> json) {
    return UtilityTypeApiResponse(
      data: List<UtilityType>.from(
        json['data'].map((e) => UtilityType.fromJson(e)),
      ),
      message: json['message'],
      status: json['status'],
    );
  }

  @override
  String toString() {
    return {
      "CLASS": "UtilityTypeApiResponse",
      "data": data,
      "message": message,
      "status": status,
    }.toString();
  }

  @override
  List<Object?> get props => [
        data,
        message,
        status,
      ];
}
