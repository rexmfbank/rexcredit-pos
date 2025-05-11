import 'package:dio/dio.dart';
import 'models/register_request.dart';
import 'models/register_response.dart';
import '../../shared_models/api_headers.dart';
import '../../utility/request/encrypt_request_template.dart';
import '../../../exceptions/data_transformer.dart';
import '../../../exceptions/rex_api_exception.dart';
import '../../../exceptions/string_constants.dart';
import '../../../utils/api_path.dart';
import '../../../utils/dio_network_provider.dart';
import '../../../utils/encryption_utils.dart';

mixin Register {
  final tokenProvider = AppNetworkProvider();

  Future<RegisterResponse> register({
    required String appVersion,
    required RegisterRequest request,
  }) async {
    final apiCall = await tokenProvider.call(
      path: ApiPath.register,
      method: RequestMethod.post,
      options: Options(headers: ApiHeaders.registerHeader(appVersion)),
      body: EncryptRequestTemplate(
        data: EncryptionUtils.encryptToApi(request.toJson()),
      ).toJson(),
    );

    final res = processData(
      (p0) {
        final jsonResponse = EncryptionUtils.decryptFromApi(p0);
        print(jsonResponse);
        return RegisterResponse.fromJson(jsonResponse);
      },
      apiCall,
    );

    res.either(
      (left) => throw RexApiException(
        message: res.left.responseMessage ?? StringConstants.exceptionMessage,
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
