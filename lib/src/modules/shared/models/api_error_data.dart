// import 'package:equatable/equatable.dart';

// class ApiErrorData extends Equatable {
//   final String flag;
//   final bool securityQuestion;

//   const ApiErrorData({
//     required this.flag,
//     required this.securityQuestion,
//   });

//   factory ApiErrorData.fromJson(Map<String, dynamic> json) {
//     return ApiErrorData(
//       flag: json['flag'],
//       securityQuestion: json['security_question'],
//     );
//   }

//   @override
//   List<Object?> get props => [flag, securityQuestion];

//   @override
//   String toString() {
//     return {
//       "CLASS": "ApiErrorData",
//       "flag": flag,
//       "securityQuestion": "$securityQuestion",
//     }.toString();
//   }
// }
