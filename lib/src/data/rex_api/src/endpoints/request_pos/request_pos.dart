import 'package:dio/dio.dart';
import 'package:rex_app/src/data/rex_api/rex_api.dart';
import '../shared_models/api_headers.dart';
import '../../exceptions/data_transformer.dart';
import '../../exceptions/rex_api_exception.dart';
import '../../exceptions/string_constants.dart';
import '../../utils/api_path.dart';
import '../../utils/dio_network_provider.dart';

mixin RequestPOS {
  final tokenProvider = AppNetworkProvider();
  final exceptionMessage = StringConstants.exceptionMessage2;

  Future<RequestPOSResponse> requestPOS({
    required String authToken,
    required RequestPOSRequest request,
  }) async {
    final apiCall = await tokenProvider.call(
      path: ApiPath.requestPOS,
      method: RequestMethod.post,
      body: request.toJson(),
      options: Options(headers: ApiHeaders.requestHeaderWithToken(authToken)),
    );

    final res = processData(
      (p0) => RequestPOSResponse.fromJson(p0),
      apiCall,
    );

    res.either(
      (left) => throw RexApiException(
        message: res.left.responseMessage ?? exceptionMessage,
      ),
      (right) => tokenProvider.parseResponse(
        responseCode: res.isRight ? res.right.responseCode : '',
        errorAction: () => throw RexApiException(
          message: res.right.responseMessage,
        ),
      ),
    );
    return res.right;
  }
}
