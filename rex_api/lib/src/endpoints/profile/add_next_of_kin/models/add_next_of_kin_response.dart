import 'package:equatable/equatable.dart';
import 'package:rex_api/src/endpoints/profile/add_next_of_kin/models/add_next_of_kin_data.dart';

class AddNextOfKinResponse extends Equatable {
  final String responseCode;
  final String responseMessage;
  final String? entityCode;
  final AddNextOfKinData data;

  AddNextOfKinResponse({
    required this.responseCode,
    required this.responseMessage,
    this.entityCode,
    required this.data,
  });

  AddNextOfKinResponse.empty()
      : data = AddNextOfKinData.empty(),
        responseCode = '',
        responseMessage = '',
        entityCode = null;

  @override
  List<Object?> get props => [responseCode, responseMessage, entityCode, data];

  factory AddNextOfKinResponse.fromJson(Map<String, dynamic> json) {
    return AddNextOfKinResponse(
      responseCode: json['responseCode'] as String,
      responseMessage: json['responseMessage'] as String,
      entityCode: json['entityCode'] as String?,
      data: AddNextOfKinData.fromJson(json['data']),
    );
  }
}
