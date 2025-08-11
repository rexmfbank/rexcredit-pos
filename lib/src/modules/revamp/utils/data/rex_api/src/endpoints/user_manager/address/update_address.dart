import 'package:dio/dio.dart';
import 'package:rex_app/src/modules/revamp/utils/data/rex_api/rex_api.dart';
import '../../shared_models/api_headers.dart';
import '../../../exceptions/data_transformer.dart';
import '../../../exceptions/rex_api_exception.dart';
import '../../../exceptions/string_constants.dart';
import '../../../utils/api_path.dart';
import '../../../utils/dio_network_provider.dart';

mixin UpdateAddress {
  static final _tokenProvider = AppNetworkProvider();

  Future<UpdateAddressResponse> updateAddress({
    required String authToken,
    required UpdateAddressRequest request,
    required Object file,
  }) async {
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
        // "file": await MultipartFile.fromFile(
        //   file.filePath,
        //   filename: file.fileName,
        // )
      }),
      options: Options(headers: ApiHeaders.requestHeaderWithToken(authToken)),
    );

    final res = processData(
      (p0) => UpdateAddressResponse.fromJson(p0),
      response,
    );
    res.either(
      (left) =>
          throw RexApiException(
            message:
                res.left.responseMessage ?? StringConstants.exceptionMessage,
          ),
      (right) => _tokenProvider.parseResponse(
        responseCode: res.isRight ? res.right.responseCode : '',
        errorAction:
            () => throw RexApiException(message: res.right.responseMessage),
      ),
    );

    return res.right;
  }
}
