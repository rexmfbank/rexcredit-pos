import 'package:dio/dio.dart';
import 'package:rex_api/src/endpoints/lookup_data/app_countries/models/app_country_response.dart';
import 'package:rex_api/src/endpoints/shared_models/api_headers.dart';
import 'package:rex_api/src/exceptions/data_transformer.dart';
import 'package:rex_api/src/exceptions/rex_api_exception.dart';
import 'package:rex_api/src/exceptions/string_constants.dart';
import 'package:rex_api/src/utils/api_path.dart';
import 'package:rex_api/src/utils/dio_network_provider.dart';

mixin AppCountries {
  Future<AppCountryResponse> appCountries() async {
    final tokenProvider = AppNetworkProvider();

    final apiCall = await tokenProvider.call(
      path: ApiPath.appCountries,
      method: RequestMethod.get,
      options: Options(headers: ApiHeaders.requestHeader),
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
