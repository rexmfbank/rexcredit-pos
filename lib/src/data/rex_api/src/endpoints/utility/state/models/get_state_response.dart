import 'package:equatable/equatable.dart';
import 'state_data.dart';

class GetStateResponse extends Equatable {
  final String status;
  final String message;
  final List<StateData> data;

  const GetStateResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory GetStateResponse.fromJson(Map<String, dynamic> json) {
    return GetStateResponse(
      status: json['status'] as String,
      message: json['message'] as String,
      data: List.from(
        json['data'].map((e) => StateData.fromJson(e)),
      ),
    );
  }

  @override
  String toString() => {
        "CLASS": "GetStateResponse",
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
