import 'package:dio/dio.dart';
import 'models/app_country_response.dart';
import '../../shared_models/api_headers.dart';
import '../../../exceptions/data_transformer.dart';
import '../../../exceptions/rex_api_exception.dart';
import '../../../exceptions/string_constants.dart';
import '../../../utils/api_path.dart';
import '../../../utils/dio_network_provider.dart';

mixin AppCountries {
  Future<AppCountryResponse> appCountries() async {
    final tokenProvider = AppNetworkProvider();

    final apiCall = await tokenProvider.call(
      path: ApiPath.appCountries,
      method: RequestMethod.get,
      options: Options(headers: ApiHeaders.headerNoTokenI),
    );

    final res = processData(
      (p0) => AppCountryResponse.fromJson(p0),
      apiCall,
    );

    res.either(
      (left) => throw RexApiException(
        message: res.left.message ?? StringConstants.exceptionMessage,
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
