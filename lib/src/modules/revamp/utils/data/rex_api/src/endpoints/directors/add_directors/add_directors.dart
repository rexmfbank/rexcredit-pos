import 'package:dio/dio.dart';
import 'package:rex_app/src/modules/revamp/utils/data/rex_api/rex_api.dart';
import '../../../exceptions/data_transformer.dart';
import '../../../utils/api_path.dart';
import '../../../utils/dio_network_provider.dart';
import '../../../exceptions/string_constants.dart';

import '../../../exceptions/rex_api_exception.dart';
import '../../shared_models/api_headers.dart';

mixin AddDirectors {
  static final _tokenProvider = AppNetworkProvider();

  Future<AddDirectorsResponse> addDirectors({
    required String authToken,
    required AddDirectorsRequest request,
  }) async {
    final response = await _tokenProvider.call(
      path: ApiPath.addDirectors,
      method: RequestMethod.post,
      body: request.toJson(),
      options: Options(
        headers: ApiHeaders.requestHeaderWithToken(authToken),
      ),
    );

    final res =
        processData((p0) => AddDirectorsResponse.fromJson(p0), response);
    res.either(
      (left) => throw RexApiException(
          message:
              res.left.responseMessage ?? StringConstants.exceptionMessage),
      (right) => _tokenProvider.parseResponse(
        responseCode: res.isRight ? res.right.responseCode : '',
        errorAction: () =>
            throw RexApiException(message: res.right.responseMessage),
      ),
    );

    return res.right;
  }

  // Future<AddDirectorsResponse> addDirectors(
  //     {required String token, required AddDirectorsRequest request}) async {
  //   try {
  //     final dio = Dio()
  //       ..interceptors.add(PrettyDioLogger(
  //         requestHeader: true,
  //         requestBody: true,
  //         responseBody: true,
  //         compact: false,
  //       ));
  //     final response = await dio.post(
  //       ApiPath.addDirectors,
  //       data: request.toJson(),
  //       options: Options(headers: ApiHeaders.requestHeaderToken(token)),
  //     );
  //     var apiResponse = AddDirectorsResponse.fromJson(response.data);
  //     if (apiResponse.responseCode == ErrorCode.SUCCESS) {
  //       return AddDirectorsResponse.fromJson(response.data);
  //     }

  //     throw RexApiException(
  //         message: apiResponse.responseMessage,
  //         responseMessage: apiResponse.responseMessage);

  //   } on DioException catch (e, stackTrace) {
  //     print("Error Response => ${e.response}");
  //     print("Error Data => ${e.response!.data}");
  //     print("Status Code => ${e.response!.statusCode}");
  //     print("Error Stack => $stackTrace");

  //     throw '$e';
  //   } catch (e, stackTrace) {
  //     print("Error => ${e.toString()}");
  //     print("Error Stack => $stackTrace");
  //     throw RexApiException(message: e.toString());
  //   }
  // }
}
