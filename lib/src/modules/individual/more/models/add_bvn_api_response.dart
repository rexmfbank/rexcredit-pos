import 'package:equatable/equatable.dart';
import 'package:rex_app/src/modules/individual/more/models/bvn_data.dart';
import 'package:rex_app/src/modules/shared/onboarding/get_started/models/meta_api_response.dart';

class AddBvnApiResponse extends Equatable {
  final BvnData data;
  final String message;
  final String status;
  final MetaApiResponse meta;

  const AddBvnApiResponse({
    required this.data,
    required this.message,
    required this.status,
    required this.meta,
  });

  const AddBvnApiResponse.empty()
      : data = const BvnData.empty(),
        message = '',
        status = '',
        meta = const MetaApiResponse.empty();

  factory AddBvnApiResponse.fromJson(Map<String, dynamic> json) {
    return AddBvnApiResponse(
      data: BvnData.fromJson(json['data']),
      message: json['message'],
      status: json['status'],
      meta: MetaApiResponse.fromJson(json['meta']),
    );
  }

  AddBvnApiResponse copyWith({
    BvnData? data,
    String? message,
    String? status,
    MetaApiResponse? meta,
  }) {
    return AddBvnApiResponse(
      data: data ?? this.data,
      message: message ?? this.message,
      status: status ?? this.status,
      meta: meta ?? this.meta,
    );
  }

  @override
  String toString() {
    return {
      "CLASS": "AddBvnApiResponse",
      "data": data,
      "message": message,
      "status": status,
      "meta": meta,
    }.toString();
  }

  @override
  List<Object?> get props => [
        data,
        message,
        status,
        meta,
      ];
}
