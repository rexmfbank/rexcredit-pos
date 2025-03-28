// import 'package:equatable/equatable.dart';
// import 'package:rex_app/src/modules/shared/onboarding/get_started/models/meta_api_response.dart';
// import 'package:rex_app/src/modules/shared/models/api_error_data.dart';

// class GenericApiResponse extends Equatable {
//   final String? status;
//   final String? message;
//   final List? data;
//   final ApiErrorData? errorData;
//   final String? token;
//   final String? tokenType;
//   final MetaApiResponse? meta;

//   bool? get hasErrorFlag => errorData?.flag.isNotEmpty;

//   const GenericApiResponse({
//     this.status,
//     this.message,
//     this.data,
//     this.errorData,
//     this.token,
//     this.tokenType,
//     this.meta,
//   });

//   const GenericApiResponse.empty()
//       : status = null,
//         message = null,
//         data = null,
//         errorData = null,
//         token = null,
//         tokenType = null,
//         meta = null;

//   factory GenericApiResponse.fromJson(Map<String, dynamic> json) {
//     return GenericApiResponse(
//       status: json['status'],
//       message: json['message'],
//       data: json['data'],
//       errorData:
//           json['error'] == null ? null : ApiErrorData.fromJson(json['error']),
//       token: json['token'],
//       tokenType: json['token_type'],
//       meta:
//           json['meta'] == null ? null : MetaApiResponse.fromJson(json['meta']),
//     );
//   }

//   GenericApiResponse copyWith({
//     String? status,
//     String? message,
//     List? data,
//     String? errorString,
//     ApiErrorData? errorData,
//     String? token,
//     String? tokenType,
//     MetaApiResponse? meta,
//   }) {
//     return GenericApiResponse(
//       status: status ?? this.status,
//       message: message ?? this.message,
//       data: data ?? this.data,
//       errorData: errorData ?? this.errorData,
//       token: token ?? this.token,
//       tokenType: tokenType ?? this.tokenType,
//       meta: meta ?? this.meta,
//     );
//   }

//   @override
//   String toString() {
//     return {
//       "CLASS": "ApiGenericResponse",
//       "status ": status,
//       "message": message,
//       "data": "$data",
//       "error": errorData,
//       "token": token,
//       "tokenType": tokenType,
//       "meta": meta,
//     }.toString();
//   }

//   @override
//   List<Object?> get props => [
//         status,
//         message,
//         data,
//         errorData,
//         token,
//         tokenType,
//         meta,
//       ];
// }
