import 'package:equatable/equatable.dart';
import 'app_country.dart';

class AppCountryResponse extends Equatable {
  final String responseCode;
  final String responseMessage;
  final List<AppCountry> data;

  const AppCountryResponse({
    required this.responseCode,
    required this.responseMessage,
    required this.data,
  });

  const AppCountryResponse.empty()
      : responseCode = '',
        responseMessage = '',
        data = const [];

  factory AppCountryResponse.fromJson(Map<String, dynamic> json) {
    return AppCountryResponse(
      responseCode: json['responseCode'] as String,
      responseMessage: json['responseMessage'] as String,
      data: List.from(
        json['data'].map((e) => AppCountry.fromJson(e)),
      ),
    );
  }

  @override
  String toString() => {
        "CLASS": "AppCountryResponse",
        "responseCode": responseCode,
        "responseMessage": responseMessage,
        "data": data
      }.toString();

  @override
  List<Object?> get props => [
        responseCode,
        responseMessage,
        data,
      ];
}
