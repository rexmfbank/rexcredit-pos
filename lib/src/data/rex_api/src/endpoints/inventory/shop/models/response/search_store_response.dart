import 'staff_model.dart';

class SearchStoreResponse {
  final String? responseCode;
  final String? responseMessage;
  final List<StaffModel>? data;

  SearchStoreResponse({
    this.responseCode,
    this.responseMessage,
    this.data,
  });

  factory SearchStoreResponse.fromJson(Map<String, dynamic> json) =>
      SearchStoreResponse(
        responseCode: json["responseCode"] ?? '',
        responseMessage: json["responseMessage"] ?? '',
        data: json["data"] == null
            ? []
            : (json["data"] as List)
                .map((e) => StaffModel.fromJson(e))
                .toList(),
      );
}
