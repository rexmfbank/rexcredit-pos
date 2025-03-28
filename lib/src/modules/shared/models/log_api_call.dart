// import 'package:flutter/foundation.dart';

// void logApiCallToConsole({
//   required String functionName,
//   required String urlPath,
//   required HttpMethodType httpMethod,
//   required ApiCallStage stage,
//   required Object data,
// }) {
//   if (kDebugMode) {
//     print('');
//     print('>>>>>>>START API ENDPOINT LOG<<<<<<<');
//     print({
//       LogKey.functionName: functionName,
//       LogKey.url: urlPath,
//       LogKey.httpMethod: httpMethod,
//       LogKey.stage: stage,
//       LogKey.data: data.toString(),
//     }.toString());
//     print('>>>>>>>END API ENDPOINT LOG<<<<<<<');
//   }
// }

// abstract class LogKey {
//   static const functionName = 'FUNCTION_NAME';
//   static const url = 'URL';
//   static const data = 'DATA';
//   static const httpMethod = 'HTTP_METHOD';
//   static const stage = 'STAGE';
// }

// enum HttpMethodType {
//   post,
//   put,
//   get,
//   patch,
// }

// enum ApiCallStage {
//   preResponse,
//   response,
//   error,
// }
