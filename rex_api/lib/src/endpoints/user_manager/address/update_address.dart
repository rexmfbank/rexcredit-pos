import 'package:dio/dio.dart';
import 'package:rex_api/rex_api.dart';
import 'package:rex_api/src/endpoints/shared_models/api_headers.dart';
import 'package:rex_api/src/exceptions/data_transformer.dart';
import 'package:rex_api/src/exceptions/rex_api_exception.dart';
import 'package:rex_api/src/exceptions/string_constants.dart';
import 'package:rex_api/src/utils/api_path.dart';
import 'package:rex_api/src/utils/dio_network_provider.dart';

mixin UpdateAddress {
  static final _tokenProvider = AppNetworkProvider();

  Future<UpdateAddressResponse> updateAddress(
      {required String authToken,
      required UpdateAddressRequest request,
      required FileFormData file}) async {
    final response = await _tokenProvider.call(
      path: ApiPath.address,
      method: RequestMethod.post,
      body: FormData.fromMap({
        "houseNo": request.houseNo,
        "street": request.street,
        "area": request.area,
        "state": request.state,
        "city": request.city,
        "lga": request.country,
        "country": request.country,
        "longitude": request.longitude,
        "latitude": request.latitude,
        // "utilityBill": "Bill info",
        // "meterNumber": "1234355390",
        "file": await MultipartFile.fromFile(
          file.filePath,
          filename: file.fileName,
        )
      }),
      options: Options(
        headers: ApiHeaders.requestHeaderWithToken(authToken),
      ),
    );

    final res =
        processData((p0) => UpdateAddressResponse.fromJson(p0), response);
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
}
