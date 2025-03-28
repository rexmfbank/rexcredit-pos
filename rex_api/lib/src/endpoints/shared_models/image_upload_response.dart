import 'dart:convert';

class ImageUploadResponse {
  String responseCode;
  String responseMessage;
  Data? data;

  ImageUploadResponse({
    required this.responseCode,
    required this.responseMessage,
    this.data,
  });

  ImageUploadResponse copyWith({
    String? responseCode,
    String? responseMessage,
    Data? data,
  }) =>
      ImageUploadResponse(
        responseCode: responseCode ?? this.responseCode,
        responseMessage: responseMessage ?? this.responseMessage,
        data: data ?? this.data,
      );

  factory ImageUploadResponse.fromRawJson(String str) => ImageUploadResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ImageUploadResponse.fromJson(Map<String, dynamic> json) => ImageUploadResponse(
    responseCode: json["responseCode"],
    responseMessage: json["responseMessage"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "responseCode": responseCode,
    "responseMessage": responseMessage,
    "data": data?.toJson(),
  };
}

class Data {
  String? id;
  String? refNo;

  Data({
    this.id,
    this.refNo,
  });

  Data copyWith({
    String? id,
    String? refNo,
  }) =>
      Data(
        id: id ?? this.id,
        refNo: refNo ?? this.refNo,
      );

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    refNo: json["refNo"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "refNo": refNo,
  };
}
